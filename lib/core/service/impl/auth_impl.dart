import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/exception/AuthException.dart';
import 'package:instagram_clone/core/service/auth.dart';

class AuthImpl extends Auth {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;

  AuthImpl() {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }

  @override
  Future<void> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required String? photoUrl}) async {
    if (email.isNotEmpty ||
        password.isNotEmpty ||
        username.isNotEmpty ||
        bio.isNotEmpty) {
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'uid': userCredential.user!.uid,
          'email': email,
          'bio': bio,
          'password': password,
          'followers': [],
          'following': [],
          "photoUrl": photoUrl,
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          throw const AuthException(TypeAuthException.weakPassword);
        } else if (e.code == 'email-already-in-use') {
          throw const AuthException(TypeAuthException.emailAlreadyInUse);
        } else if (e.code == 'operation-not-allowed') {
          throw const AuthException(TypeAuthException.operationNotAllowed);
        } else {
          rethrow;
        }
      }
    }
  }
}
