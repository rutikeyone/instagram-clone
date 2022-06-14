import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/model/user.dart' as model;

class ReceiveAuthorizedUser {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<model.User?> receiveUser() async {
    final User? user = firebaseAuth.currentUser;

    if (user != null) {
      final DocumentSnapshot documentSnapshot =
          await firebaseFirestore.collection('users').doc(user.uid).get();
      if (documentSnapshot.data() != null) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final user = model.User.fromMap(data);
        return user;
      }
    }

    return null;
  }
}
