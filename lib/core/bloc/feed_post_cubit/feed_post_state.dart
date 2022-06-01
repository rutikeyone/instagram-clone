part of 'feed_post_cubit.dart';

abstract class FeedPostState extends Equatable {
  const FeedPostState();

  @override
  List<Object> get props => [];
}

class FeedPostInitial extends FeedPostState {}

class FeedPostLoading extends FeedPostState {}
