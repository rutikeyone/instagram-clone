import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/model/comment.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart' as model;
import 'package:instagram_clone/core/service/firestore.dart';
import 'package:instagram_clone/core/utils/mixin/receive_authorized_user.dart';

import '../../utils/mixin/receive_comments_with_post.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState>
    with ReceiveAuthorizedUser, ReceiveCommentsWithPost {
  final Firestore firestore;
  late TextEditingController? commentController;

  CommentsCubit({required this.firestore}) : super(CommentsState.empty());

  void init() {
    commentController = TextEditingController();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get commentsStream =>
      firebaseFirestore
          .collection('posts')
          .doc(state.post.postId)
          .collection('comments')
          .orderBy('datePublished')
          .snapshots();

  void clear() {
    commentController?.clear();
  }

  void postComment() async {
    if (commentController != null && commentController!.text.isNotEmpty) {
      try {
        firestore.postComment(state.post.postId, commentController!.text,
            state.user.uid, state.user.username, state.user.photoUrl);
        clear();
        List<Comment> comments =
            await receiveCommentsWithPost(state.post, firebaseFirestore);
        emit(state.copyWith(comments: comments));
      } catch (e) {}
    }
  }

  void dispose() {
    commentController?.dispose();
  }
}
