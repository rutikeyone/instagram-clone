part of 'feed_post_cubit.dart';

abstract class FeedPostState extends Equatable {
  const FeedPostState();

  @override
  List<Object?> get props => [];
}

class FeedPostInitial extends FeedPostState {
  final List<Post>? posts;

  @override
  List<Object?> get props => [posts];
  const FeedPostInitial({this.posts});

  FeedPostInitial copyWith({
    List<Post>? posts,
  }) {
    return FeedPostInitial(
      posts: posts ?? this.posts,
    );
  }
}

class FeedPostLoading extends FeedPostState {}
