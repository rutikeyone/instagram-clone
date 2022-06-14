import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/model/user.dart' as model;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;

  ProfileCubit()
      : _auth = FirebaseAuth.instance,
        _firebaseFirestore = FirebaseFirestore.instance,
        super(const ProfileState());

  Stream<DocumentSnapshot<Map<String, dynamic>>> get profileStream =>
      _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> get postsAuthorizedUserStream =>
      _firebaseFirestore
          .collection('posts')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .snapshots();

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
