import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone/core/navigation/route_generator.dart';
import '../../model/password.dart';
import '../../model/username.dart';
import 'package:flutter/material.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void onUsernameChanged(String value) {
    final Username username = Username.dirty(value);
    emit(state.copyWith(
        username: username,
        status: Formz.validate([username, state.password])));
  }

  void onPasswordChanged(String value) {
    final Password password = Password.dirty(value);
    emit(state.copyWith(
        password: password,
        status: Formz.validate([password, state.username])));
  }

  void loginWithUserNameAndPassword() async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }

  void navigationInSignUp(BuildContext context) {
    emit(state.copyWith(
      username: const Username.pure(),
      status: FormzStatus.valid,
      password: const Password.pure(),
    ));
    Navigator.of(context).pushNamed(signupRouteName);
  }
}
