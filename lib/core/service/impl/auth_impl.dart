import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/service/auth.dart';
import 'package:instagram_clone/core/model/user.dart' as model;
import '../../utils/exception/AuthException.dart';

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
      required String? photoUrl,
      required String uid}) async {
    if (email.isNotEmpty ||
        password.isNotEmpty ||
        username.isNotEmpty ||
        bio.isNotEmpty) {
      try {
        model.User newUser = model.User(
          username: username,
          uid: uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl ?? "",
        );
        await _firestore.collection('users').doc(uid).set(newUser.toMap());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          throw const AuthException(TypeAuthException.weakPassword);
        } else if (e.code == 'email-already-in-use') {
          throw const AuthException(TypeAuthException.emailAlreadyInUse);
        } else if (e.code == 'operation-not-allowed') {
          throw const AuthException(TypeAuthException.operationNotAllowed);
        } else if (e.code == 'invalid-email') {
          throw const AuthException(TypeAuthException.invalidEmail);
        } else {
          rethrow;
        }
      }
    }
  }

  @override
  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw const AuthException(TypeAuthException.invalidEmail);
      } else if (e.code == 'user-disabled') {
        throw const AuthException(TypeAuthException.userDisabled);
      } else if (e.code == 'user-not-found') {
        throw const AuthException(TypeAuthException.userNotFound);
      } else if (e.code == 'wrong-password') {
        throw const AuthException(TypeAuthException.wrongPassword);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
