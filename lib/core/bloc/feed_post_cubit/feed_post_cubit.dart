import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/model/user.dart' as model;
import 'package:instagram_clone/core/utils/mixin/receive_authorized_user.dart';

import '../../model/post.dart';
import '../../service/firestore.dart';

part 'feed_post_state.dart';

class FeedPostCubit extends Cubit<FeedPostState> with ReceiveAuthorizedUser {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  late List<Post> posts;
  final Firestore firestoreService;
  late StreamController _streamController;

  FeedPostCubit(
      {required this.firestoreService,
      required this.firebaseAuth,
      required this.firebaseFirestore})
      : posts = [],
        super(const FeedPostInitial(user: model.User.empty(), posts: []));

  void initStream() {
    _initStreamController();
    _listenPosts();
  }

  void _initStreamController() {
    _streamController = StreamController();
    _streamController
        .addStream(firebaseFirestore.collection('posts').snapshots());
  }

  void _listenPosts() {
    _streamController.stream.listen((data) async {
      final List<Post> updatedList = [];
      for (int i = 0; i < data.docs.length; i++) {
        final newPost = Post.fromSnapshot(data.docs[i]);
        updatedList.add(newPost);
      }
      posts.clear();
      posts.addAll(updatedList);

      emit(FeedPostInitial(posts: updatedList, user: const model.User.empty()));
    });
  }

  Future<void> establishAuthorizedUser() async {
    if (state is FeedPostInitial) {
      final initialState = state as FeedPostInitial;

      final model.User? user = await receiveUser(
          firebaseAuth: firebaseAuth, firebaseFirestore: firebaseFirestore);

      if (user != null) {
        emit(initialState.copyWith(user: user));
      }
    }
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      await firestoreService.likePost(postId, uid, likes);
    } catch (e) {}
  }

  Future<void> notLikePost(String postId, String uid, List likes) async {
    try {
      await firestoreService.notLikePost(postId, uid, likes);
    } catch (e) {}
  }

  void deletePost(String postId) async {
    try {
      await firestoreService.deletePost(postId);
    } catch (e) {}
  }

  void dispose() {
    _streamController.close();
  }
}
