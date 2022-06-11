import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart' as model;
import 'package:instagram_clone/core/service/firestore.dart';
import 'package:instagram_clone/core/utils/mixin/receive_authorized_user.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> with ReceiveAuthorizedUser {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final Firestore firestore;
  late TextEditingController? commentController;
  CommentsCubit(
      {required this.firebaseFirestore,
      required this.firebaseAuth,
      required this.firestore})
      : super(
            CommentsState(user: const model.User.empty(), post: Post.empty()));

  Future<void> init(Post post) async {
    await _establishUser();
    _establishPost(post);
    _initCommentController();
  }

  Future<void> _establishUser() async {
    final model.User? user = await receiveUser(
        firebaseAuth: firebaseAuth, firebaseFirestore: firebaseFirestore);

    if (user != null) {
      emit(state.copyWith(user: user));
    }
  }

  void _initCommentController() {
    commentController = TextEditingController();
  }

  void _establishPost(Post post) {
    emit(state.copyWith(post: post));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get commentsStream =>
      firebaseFirestore
          .collection('posts')
          .doc(state.post.postId)
          .collection('comments')
          .snapshots();

  void clear() {
    commentController?.clear();
  }

  void postComment() {
    if (commentController != null && commentController!.text.isNotEmpty) {
      try {
        firestore.postComment(state.post.postId, commentController!.text,
            state.user.uid, state.user.username, state.user.photoUrl);
        clear();
      } catch (e) {}
    }
  }

  void dispose() {
    commentController?.dispose();
    commentController = null;
  }
}
