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
        super(const ProfileState.empty());

  void init() {
    _receiveAuthorizedUser();
  }

  void _receiveAuthorizedUser() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final DocumentSnapshot documentSnapshot = await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      if (documentSnapshot.data() != null) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final user = model.User.fromMap(data);
        emit(ProfileState(user: user));
      }
    }
  }
}
