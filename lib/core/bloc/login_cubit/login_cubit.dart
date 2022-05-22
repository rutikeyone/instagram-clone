import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone/core/model/email.dart';
import 'package:instagram_clone/core/service/auth.dart';
import 'package:instagram_clone/presentation/login/state/login_loading.dart';
import '../../model/password.dart';
import '../../model/username.dart';
import '../../utils/exception/AuthException.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Auth auth;
  LoginCubit({required this.auth}) : super(LoginInitial());

  void emitLoginCreareUser() {
    emit(LoginCreateUser());
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
      final Email email = Email.dirty(value);
      emit(initialState.copyWith(
          email: email,
          status: Formz.validate([email, initialState.password])));
    }
  }

  void onPasswordChanged(String value) {
    if (state is LoginInitial) {
      final initialState = state as LoginInitial;
      final Password password = Password.dirty(value);
      emit(initialState.copyWith(
          password: password,
          status: Formz.validate([password, initialState.email])));
    }
  }

  void loginWithUserNameAndPassword() async {
    if (state is LoginInitial) {
      final initialState = state as LoginInitial;
      onEmailChanged(initialState.email.value);
      onPasswordChanged(initialState.password.value);
      if (initialState.status.isValidated) {
        emit(LoginUserLoading());
        try {
          await auth.loginUser(
              email: initialState.email.value,
              password: initialState.email.value);
          emit(LoginUserSuccess());
        } on AuthException catch (e) {}
      }
    }
  }
}
