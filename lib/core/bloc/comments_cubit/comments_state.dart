part of 'comments_cubit.dart';

class CommentsState extends Equatable {
  final model.User user;
  final Post post;
  final List<Comment> comments;

  CommentsState.empty()
      : user = const model.User.empty(),
        post = Post.empty(),
        comments = const [];

  const CommentsState(
      {required this.user, required this.post, required this.comments});

  @override
  List<Object?> get props => [user, post, comments];

  CommentsState copyWith({
    model.User? user,
    Post? post,
    List<Comment>? comments,
  }) {
    return CommentsState(
      user: user ?? this.user,
      post: post ?? this.post,
      comments: comments ?? this.comments,
    );
  }
}
