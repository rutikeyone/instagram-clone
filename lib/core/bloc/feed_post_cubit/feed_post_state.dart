// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'feed_post_cubit.dart';

abstract class FeedPostState extends Equatable {
  const FeedPostState();

  @override
  List<Object?> get props => [];
}

class FeedPostInitial extends FeedPostState {
  final model.User? user;
  final List<Post>? posts;

  @override
  List<Object?> get props => [posts, user];

  const FeedPostInitial({required this.user, required this.posts});

  FeedPostInitial copyWith({
    model.User? user,
    List<Post>? posts,
  }) {
    return FeedPostInitial(
      user: user ?? this.user,
      posts: posts ?? this.posts,
    );
  }
}

class FeedPostLoading extends FeedPostState {}
