part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    this.bio = const Bio.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final Email email;
  final Bio bio;

  SignupState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    Email? email,
    Bio? bio,
  }) {
    return SignupState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }

  @override
  List<Object> get props => [status, username, password, email, bio];
}
