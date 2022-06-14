import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart' as model;
import 'package:instagram_clone/core/service/auth.dart';
import 'package:instagram_clone/core/utils/mixin/receive_authorized_user.dart';
import 'package:instagram_clone/core/utils/mixin/receive_posts.dart';
import 'package:instagram_clone/generated/l10n.dart';
import '../../utils/exception/AuthException.dart';
import '../../validate_model/email_validate.dart';
import '../../validate_model/password_validate.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState>
    with ReceiveAuthorizedUser, ReceivePosts {
  final Auth auth;
  late TextEditingController emainController;
  late TextEditingController passwordController;
  LoginCubit({
    required this.auth,
  }) : super(LoginInitial());

  void init() {
    emainController = TextEditingController();
    passwordController = TextEditingController();
    emitLoginInitial();
  }

  void emitLoginCreareUser() {
    emit(LoginCreateUser());
    clean();
  }

  void emitBack() {
    emit(LoginBack());
  }

  void emitLoginInitial() {
    emit(LoginInitial());
  }

  void onEmailChanged(String value) {
    if (state is LoginInitial) {
      final initialState = state as LoginInitial;
      final EmailValidate email = EmailValidate.dirty(value);
      emit(initialState.copyWith(
          email: email,
          status: Formz.validate([email, initialState.password])));
    }
  }

  void onPasswordChanged(String value) {
    if (state is LoginInitial) {
      final initialState = state as LoginInitial;
      final PasswordValidate password = PasswordValidate.dirty(value);
      emit(initialState.copyWith(
          password: password,
          status: Formz.validate([password, initialState.email])));
    }
  }

  Future<void> loginWithUserNameAndPassword() async {
    if (state is LoginInitial) {
      final initialState = state as LoginInitial;
      onEmailChanged(initialState.email.value);
      onPasswordChanged(initialState.password.value);
      if (initialState.status.isValidated) {
        emit(LoginUserLoading());
        try {
          await auth.loginUser(
              email: initialState.email.value,
              password: initialState.password.value);

          final model.User? user = await receiveUser();

          final posts = await receivePosts(firebaseFirestore);

          emit(LoginUserSuccess(user: user!, posts: posts));
        } on AuthException catch (e) {
          emitLoginUserFailureWithException(e);
        } catch (e) {
          emit(LoginUserFailure(e.toString()));
        }
      }
    }
  }

  void emitLoginUserFailureWithException(AuthException e) {
    switch (e.exception) {
      case TypeAuthException.invalidEmail:
        emit(LoginUserFailure(S.current.invalid_email));
        break;
      case TypeAuthException.userDisabled:
        emit(LoginUserFailure(S.current.user_disabled));
        break;
      case TypeAuthException.userNotFound:
        emit(LoginUserFailure(S.current.user_not_found));
        break;
      case TypeAuthException.wrongPassword:
        emit(LoginUserFailure(S.current.wrong_password));
        break;
      default:
        break;
    }
  }

  void clean() {
    emainController.clear();
    passwordController.clear();
  }

  void dispose() {
    emainController.dispose();
    passwordController.dispose();
  }
}
