import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/model/user.dart' as model;

import '../../model/post.dart';
import '../../service/firestore.dart';

part 'feed_post_state.dart';

class FeedPostCubit extends Cubit<FeedPostState> {
  final FirebaseFirestore firebaseFirestore;
  final List<Post> posts;
  final Firestore firebaseService;
  final StreamController _streamController;
  final Stream<QuerySnapshot<Map<String, dynamic>>> postsStream;

  FeedPostCubit(
      {required this.firebaseService, required this.firebaseFirestore})
      : posts = [],
        _streamController = StreamController()
          ..sink.add(firebaseFirestore.collection('posts').snapshots()),
        postsStream = firebaseFirestore.collection('posts').snapshots(),
        super(const FeedPostInitial(posts: []));

  void listenPostItem() {
    _streamController.stream.listen((data) {
      if (state is FeedPostInitial) {
        final FeedPostInitial feedPostInitial = state as FeedPostInitial;
        final List<Post> updatedList = [];
        for (int i = 0; i < data.docs.length; i++) {
          final newPost = Post.fromSnapshot(data.docs[i]);
          updatedList.add(newPost);
        }

        posts.clear();
        posts.addAll(updatedList);
        emit(FeedPostInitial(posts: updatedList));
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

  void emitFeedInitial() {
    emit(FeedPostInitial(posts: posts));
  }

  void dispose() {
    _streamController.close();
  }
}
