import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart' as model;
import 'package:instagram_clone/core/validate_model/comment_validate.dart';
import '../../model/comment.dart';
import '../../service/firestore.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final FirebaseAuth _auth;
  final Firestore firestore;
  late final FirebaseFirestore firebaseFirestore;
  late StreamController? _streamController;
  final List<Comment> comments;

  CommentsCubit({required this.firestore, required this.firebaseFirestore})
      : _auth = FirebaseAuth.instance,
        comments = [],
        super(CommentsInitial(
            user: model.User.empty(), post: Post.empty(), comments: const []));

  Future<void> establishUser() async {
    final User? user = _auth.currentUser;

    if (user != null && state is CommentsInitial) {
      final initialState = state as CommentsInitial;
      final DocumentSnapshot documentSnapshot = await firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      if (documentSnapshot.data() != null) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        final user = model.User.fromMap(data);
        emit(initialState.copyWith(user: user));
      } else {
        emit(initialState.copyWith(user: model.User.empty()));
      }
    } else {
      emit(CommentsInitial(
          user: model.User.empty(), post: Post.empty(), comments: const []));
    }
  }

  void listenCommentItem() {
    _streamController?.stream.listen((snapshot) async {
      final QuerySnapshot<Map<String, dynamic>> data = await snapshot;
      if (state is CommentsInitial) {
        final initialState = state as CommentsInitial;
        final List<Comment> updateCommets = [];
        for (int i = 0; i < data.docs.length; i++) {
          final newComment = Comment.fromSnapshot(data.docs[i]);
          updateCommets.add(newComment);
        }

        comments.clear();
        comments.addAll(updateCommets);
        emit(initialState.copyWith(comments: comments));
      }
    });
  }

  void establishPost(Post post) {
    if (state is CommentsInitial) {
      final initialState = state as CommentsInitial;
      _streamController = StreamController();
      _streamController?.sink.add(firebaseFirestore
          .collection('posts')
          .doc(post.postId)
          .collection('comments')
          .snapshots()
          .first);
      emit(initialState.copyWith(post: post));
    }
  }

  void onCommentChanged(String value) {
    if (state is CommentsInitial) {
      final initialState = state as CommentsInitial;
      final CommentValidate comment = CommentValidate.dirty(value);
      emit(initialState.copyWith(
        comment: comment,
        status: Formz.validate([comment]),
      ));
    }
  }

  void postComment() {
    if (state is CommentsInitial) {
      final initialState = state as CommentsInitial;
      if (initialState.status.isValidated) {
        try {
          firestore.postComment(
              initialState.post.postId,
              initialState.comment.value,
              initialState.user.uid,
              initialState.user.username,
              initialState.user.photoUrl);
        } catch (e) {}
      }
    }
  }

  void clear() {
    if (state is CommentsInitial) {
      final initialState = state as CommentsInitial;
      emit(initialState.copyWith(comments: const []));
    }
  }

  void dispose() {
    _streamController?.close();
    _streamController = null;
  }
}
