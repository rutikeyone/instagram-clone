part of 'comments_cubit.dart';

class CommentsState extends Equatable {
  final model.User user;
  final Post post;

  CommentsState.empty()
      : user = const model.User.empty(),
        post = Post.empty();

  const CommentsState({required this.user, required this.post});

  @override
  List<Object?> get props => [user, post];

  CommentsState copyWith({
    model.User? user,
    Post? post,
    List<Comment>? comments,
  }) {
    return CommentsState(
      user: user ?? this.user,
      post: post ?? this.post,
    );
  }
}
