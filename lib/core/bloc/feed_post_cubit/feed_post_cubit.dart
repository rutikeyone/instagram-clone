import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/model/user.dart' as model;
import 'package:instagram_clone/core/utils/mixin/receive_authorized_user.dart';
import 'package:instagram_clone/core/utils/mixin/receive_comments_with_post.dart';
import '../../model/post.dart';
import '../../service/firestore.dart';

part 'feed_post_state.dart';

class FeedPostCubit extends Cubit<FeedPostState>
    with ReceiveAuthorizedUser, ReceiveCommentsWithPost {
  final Firestore firestoreService;

  FeedPostCubit({
    required this.firestoreService,
  }) : super(FeedPostState());

  Stream<QuerySnapshot<Map<String, dynamic>>> get postsStream =>
      firebaseFirestore.collection('posts').snapshots();

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
}
