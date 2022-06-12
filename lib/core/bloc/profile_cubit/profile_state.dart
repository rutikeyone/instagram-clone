// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final model.User user;
  final List<Post> posts;

  const ProfileState({required this.user, required this.posts});

  const ProfileState.empty()
      : user = const model.User.empty(),
        posts = const [];

  @override
  List<Object?> get props => [user, posts];

  ProfileState copyWith({
    model.User? user,
    List<Post>? posts,
  }) {
    return ProfileState(
      user: user ?? this.user,
      posts: posts ?? this.posts,
    );
  }
}

class ProfileSignOut extends ProfileState {
  const ProfileSignOut({required super.user, required super.posts});
}
