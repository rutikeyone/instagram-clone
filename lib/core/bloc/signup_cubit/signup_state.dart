part of 'signup_cubit.dart';

abstract class SignState extends Equatable {}

class SignCreateUserSuccess extends SignState {
  @override
  List<Object?> get props => [];
}

class SignCreateUserLoading extends SignState {
  @override
  List<Object?> get props => [];
}

class SignCreateUserFailure extends SignState {
  final String errorMessage;

  SignCreateUserFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class SignBack extends SignState {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignState {
  SignupInitial({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    this.bio = const Bio.pure(),
    this.file,
  });

  @override
  List<Object?> get props => [status, username, password, email, bio, file];

  final FormzStatus status;
  final Username username;
  final Password password;
  final Email email;
  final Bio bio;
  final Uint8List? file;

  SignupInitial copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    Email? email,
    Bio? bio,
    Uint8List? file,
  }) {
    return SignupInitial(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      file: file ?? this.file,
    );
  }
}
