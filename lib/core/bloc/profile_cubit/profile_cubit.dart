import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart' as model;

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;
  ProfileCubit()
      : _auth = FirebaseAuth.instance,
        _firebaseFirestore = FirebaseFirestore.instance,
        super(const ProfileState.empty());

  void init() async {
    await _receiveAuthorizedUser();
    await _receiveUserPosts();
  }

  Future<void> _receiveAuthorizedUser() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final DocumentSnapshot documentSnapshot = await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      if (documentSnapshot.data() != null) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final user = model.User.fromMap(data);
        emit(state.copyWith(user: user));
      }
    }
  }

  Future<void> _receiveUserPosts() async {
    final data = await _firebaseFirestore
        .collection('posts')
        .where('uid', isEqualTo: state.user.uid)
        .get();
    final documents = data.docs;
    final List<Post> posts =
        documents.map((e) => Post.fromSnapshot(e)).toList();
    emit(state.copyWith(posts: posts));
  }

  Future<void> signOut() async {
    await _auth.signOut();
    emit(const ProfileSignOut(user: model.User.empty(), posts: []));
  }
}
