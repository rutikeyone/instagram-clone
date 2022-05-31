part of 'login_cubit.dart';

abstract class LoginState extends Equatable {}

class LoginUserSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginUserFailure extends LoginState {
  final String errorMessage;

  LoginUserFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class LoginUserLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginCreateUser extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginBack extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  LoginInitial({
    this.status = FormzStatus.pure,
    this.email = const EmailValidate.pure(),
    this.password = const PasswordValidate.pure(),
  });

  final FormzStatus status;
  final EmailValidate email;
  final PasswordValidate password;

  LoginInitial copyWith({
    FormzStatus? status,
    EmailValidate? email,
    PasswordValidate? password,
  }) {
    return LoginInitial(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, email, password];
}
