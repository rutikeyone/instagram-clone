import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone/core/model/bio.dart';
import 'package:instagram_clone/core/model/email.dart';
import 'package:instagram_clone/core/model/password.dart';
import 'package:instagram_clone/core/model/username.dart';
import 'package:instagram_clone/core/service/auth.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final Auth auth;

  SignupCubit({required this.auth}) : super(const SignupState());

  void onEmailChanged(String value) {
    final Email email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        status: Formz.validate(
            [email, state.bio, state.password, state.username])));
  }

  void onUsernameChanged(String value) {
    final Username username = Username.dirty(value);
    emit(state.copyWith(
        username: username,
        status: Formz.validate(
            [username, state.bio, state.password, state.email])));
  }

  void onPasswordChanged(String value) {
    final Password password = Password.dirty(value);
    emit(state.copyWith(
        password: password,
        status: Formz.validate(
            [password, state.bio, state.username, state.email])));
  }

  void onBioChanged(String value) {
    final Bio bio = Bio.dirty(value);
    emit(state.copyWith(
        bio: bio,
        status: Formz.validate(
            [bio, state.password, state.username, state.email])));
  }

  void signUp() async {
    if (state.status.isValidated) {
      await auth.signUpUser(
          username: state.username.value,
          email: state.email.value,
          password: state.password.value,
          bio: state.bio.value);
      emit(state.copyWith(
        username: const Username.pure(),
        email: const Email.pure(),
        password: const Password.pure(),
        bio: const Bio.pure(),
        status: FormzStatus.submissionSuccess,
      ));
    }
  }
}
