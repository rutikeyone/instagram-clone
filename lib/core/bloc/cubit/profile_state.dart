part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final model.User user;

  const ProfileState({required this.user});

  const ProfileState.empty() : user = const model.User.empty();

  @override
  List<Object?> get props => [user];

  ProfileState copyWith({
    model.User? user,
  }) {
    return ProfileState(
      user: user ?? this.user,
    );
  }
}
