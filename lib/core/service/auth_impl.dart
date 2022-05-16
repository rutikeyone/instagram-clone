import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/service/auth.dart';

class AuthImpl extends Auth {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;

  AuthImpl() {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }

  @override
  Future<void> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
  }) async {
    if (email.isNotEmpty ||
        password.isNotEmpty ||
        username.isNotEmpty ||
        bio.isNotEmpty) {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'uid': userCredential.user!.uid,
        'email': email,
        'bio': bio,
        'followers': [],
        'following': [],
      });
    }
  }
}
