part of 'comments_cubit.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object?> get props => [];
}

class CommentsInitial extends CommentsState {
  final model.User user;
  final FormzStatus status;
  final CommentValidate comment;
  final Post post;
  final List<Comment> comments;

  const CommentsInitial({
    required this.user,
    required this.comments,
    this.comment = const CommentValidate.pure(),
    this.status = FormzStatus.pure,
    required this.post,
  });

  @override
  List<Object?> get props => [user, status, comment, comments, post];

  CommentsInitial copyWith({
    model.User? user,
    FormzStatus? status,
    CommentValidate? comment,
    Post? post,
    List<Comment>? comments,
  }) {
    return CommentsInitial(
      user: user ?? this.user,
      status: status ?? this.status,
      comment: comment ?? this.comment,
      post: post ?? this.post,
      comments: comments ?? this.comments,
    );
  }
}
