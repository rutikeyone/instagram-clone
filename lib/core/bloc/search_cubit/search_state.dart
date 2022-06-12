part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchPosts extends SearchState {
  final List<Post> posts;

  @override
  List<Object> get props => [posts];
  const SearchPosts({required this.posts});
}

class SearchLoading extends SearchState {}

class SearchUsers extends SearchState {
  final List<User> users;

  @override
  List<Object> get props => [users];
  const SearchUsers({required this.users});
}
