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
  final Firestore firebaseService;
  late StreamController _streamController;

  FeedPostCubit(
      {required this.firebaseService,
      required this.firebaseAuth,
      required this.firebaseFirestore})
      : posts = [],
        super(FeedPostLoading());

  Future<void> init() async {
    _initStreamController();
    _init();
  }

  void _initStreamController() {
    _streamController = StreamController();
    _streamController
        .addStream(firebaseFirestore.collection('posts').snapshots());
  }

  void _init() {
    _streamController.stream.listen((data) async {
      final List<Post> updatedList = [];
      for (int i = 0; i < data.docs.length; i++) {
        final newPost = Post.fromSnapshot(data.docs[i]);
        updatedList.add(newPost);
      }
      posts.clear();
      posts.addAll(updatedList);

      final model.User? user = await receiveUser(
          firebaseAuth: firebaseAuth, firebaseFirestore: firebaseFirestore);

      if (user != null) {
        emit(FeedPostInitial(posts: updatedList, user: user));
      } else {
        emit(FeedPostInitial(
            posts: updatedList, user: const model.User.empty()));
      }
    });
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      await firebaseService.likePost(postId, uid, likes);
    } catch (e) {}
  }

  Future<void> notLikePost(String postId, String uid, List likes) async {
    try {
      await firebaseService.notLikePost(postId, uid, likes);
    } catch (e) {}
  }

  void dispose() {
    _streamController.close();
  }
}
