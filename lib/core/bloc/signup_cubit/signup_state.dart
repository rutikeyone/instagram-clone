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
    this.username = const UsernameValidate.pure(),
    this.password = const PasswordValidate.pure(),
    this.email = const EmailValidate.pure(),
    this.bio = const BioValidate.pure(),
    this.file,
  });

  @override
  List<Object?> get props => [status, username, password, email, bio, file];

  final FormzStatus status;
  final UsernameValidate username;
  final PasswordValidate password;
  final EmailValidate email;
  final BioValidate bio;
  final Uint8List? file;

  SignupInitial copyWith({
    FormzStatus? status,
    UsernameValidate? username,
    PasswordValidate? password,
    EmailValidate? email,
    BioValidate? bio,
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
