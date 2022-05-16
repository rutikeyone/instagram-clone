import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/model/bio.dart';
import 'package:instagram_clone/core/model/email.dart';
import 'package:instagram_clone/core/model/password.dart';
import 'package:instagram_clone/core/model/username.dart';
import 'package:instagram_clone/core/service/auth.dart';
import 'package:instagram_clone/core/service/picker.dart';
import 'package:instagram_clone/core/service/storage.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final Auth auth;
  final Picker picker;
  final Storage storage;

  SignupCubit({required this.auth, required this.picker, required this.storage})
      : super(const SignupState());

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

  void pickImage() async {
    final Uint8List? imageList = await picker.pickImage(ImageSource.gallery);
    if (imageList != null) {
      emit(state.copyWith(file: imageList));
    }
  }

  void signUp() async {
    late final String? photoUrl;
    if (state.file != null) {
      // photoUrl =
      //     await storage.uploadImageToStorage("profilePics", state.file!, false);
    }

    // await auth.signUpUser(
    //   username: state.username.value,
    //   email: state.email.value,
    //   password: state.password.value,
    //   bio: state.bio.value,
    //   photoUrl: photoUrl ?? "",
    // );

    clear();
  }

  bool validate() {
    onEmailChanged(state.email.value);
    onUsernameChanged(state.username.value);
    onPasswordChanged(state.password.value);
    onBioChanged(state.bio.value);
    if (state.status.isValidated) {
      return true;
    }
    return false;
  }

  void clear() async {
    final bytes = await rootBundle.load("assets/default_logo_avatar.png");
    final list = bytes.buffer.asUint8List();

    emit(state.copyWith(
      username: const Username.pure(),
      email: const Email.pure(),
      password: const Password.pure(),
      bio: const Bio.pure(),
      file: list,
      status: Formz.validate(
          [state.username, state.email, state.password, state.bio]),
    ));
  }
}
