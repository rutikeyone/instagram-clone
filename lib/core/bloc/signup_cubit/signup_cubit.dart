import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class SignupCubit extends Cubit<SignState> {
  final Auth auth;
  final Picker picker;
  final Storage storage;

  SignupCubit({required this.auth, required this.picker, required this.storage})
      : super(SignupInitial());

  void emitSignupInitial() {
    emit(SignupInitial());
  }

  void onEmailChanged(String value) {
    if (state is SignupInitial) {
      final initialState = state as SignupInitial;
      final Email email = Email.dirty(value);
      emit(initialState.copyWith(
          email: email,
          status: Formz.validate([
            email,
            initialState.bio,
            initialState.password,
            initialState.username
          ])));
    }
  }

  void onUsernameChanged(String value) {
    if (state is SignupInitial) {
      final initialState = state as SignupInitial;
      final Username username = Username.dirty(value);
      emit(initialState.copyWith(
          username: username,
          status: Formz.validate([
            username,
            initialState.bio,
            initialState.password,
            initialState.email
          ])));
    }
  }

  void onPasswordChanged(String value) {
    if (state is SignupInitial) {
      final initialState = state as SignupInitial;
      final Password password = Password.dirty(value);
      emit(initialState.copyWith(
          password: password,
          status: Formz.validate([
            password,
            initialState.bio,
            initialState.username,
            initialState.email
          ])));
    }
  }

  void onBioChanged(String value) {
    final initialState = state as SignupInitial;
    final Bio bio = Bio.dirty(value);
    emit(initialState.copyWith(
        bio: bio,
        status: Formz.validate([
          bio,
          initialState.password,
          initialState.username,
          initialState.email
        ])));
  }

  void pickImage() async {
    if (state is SignupInitial) {
      final initialState = state as SignupInitial;
      final Uint8List? imageList = await picker.pickImage(ImageSource.gallery);
      if (imageList != null) {
        emit(initialState.copyWith(file: imageList));
      }
    }
  }

  void signUp() async {
    if (state is SignupInitial) {
      final initialState = state as SignupInitial;
      onEmailChanged(initialState.email.value);
      onUsernameChanged(initialState.username.value);
      onPasswordChanged(initialState.password.value);
      onBioChanged(initialState.bio.value);
      if (initialState.status.isValidated) {
        emit(SignCreateUserLoading());
        late final String? photoUrl;
        if (initialState.file != null) {
          photoUrl = await storage.uploadImageToStorage(
              "profilePics", initialState.file!, false);
        } else {
          photoUrl = null;
        }

        try {
          await auth.signUpUser(
            username: initialState.username.value,
            email: initialState.email.value,
            password: initialState.password.value,
            bio: initialState.bio.value,
            photoUrl: photoUrl ?? "",
          );
          emit(SignCreateUserSuccess());
        } on PlatformException catch (e) {
          emit(SignCreateUserFailure(e.toString()));
        }
      }
    }
  }

  void clear() async {
    if (state is SignupInitial) {
      final initialState = state as SignupInitial;
      final bytes = await rootBundle.load("assets/default_logo_avatar.png");
      final list = bytes.buffer.asUint8List();

      emit(initialState.copyWith(
        username: const Username.pure(),
        email: const Email.pure(),
        password: const Password.pure(),
        bio: const Bio.pure(),
        file: list,
        status: Formz.validate([
          initialState.username,
          initialState.email,
          initialState.password,
          initialState.bio
        ]),
      ));
    }
  }
}
