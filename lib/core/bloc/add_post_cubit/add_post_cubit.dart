import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/service/firestore.dart';
import '../../validate_model/post_validate.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final Firestore firestoreService;

  final ImagePicker _picker = ImagePicker();
  AddPostCubit({required this.firestoreService}) : super(AddPostUpload());

  void closeAlertDialog(BuildContext context) async {
    Navigator.of(context).pop();
    emit(AddPostUpload());
  }

  void navigateToAddPostUpload() {
    emit(AddPostUpload());
  }

  void showAlertDialog() {
    emit(AddPostShowAlertDialog());
  }

  void emitAddPostUpload() {
    emit(AddPostUpload());
  }

  void addPostWithPhoto(ImageSource imageSource) async {
    final file = await _picker.pickImage(source: imageSource);

    if (file != null) {
      emit(AddPostWrite(imagePath: file.path));
    } else {
      emit(AddPostUpload());
    }
  }

  void onPostChanged(String value) {
    if (state is AddPostWrite) {
      final writeState = state as AddPostWrite;
      final PostValidate post = PostValidate.dirty(value);
      emit(writeState.copyWith(post: post, status: Formz.validate([post])));
    }
  }

  void makePost(String uid, String username, String profileImage) async {
    if (state is AddPostWrite) {
      final writeState = state as AddPostWrite;
      onPostChanged(writeState.post.value);
      if (writeState.status.isValidated) {
        Uint8List file = await File(writeState.imagePath).readAsBytes();
        try {
          emit(AddPostLoading());
          await firestoreService.uploadPost(
              writeState.post.value, file, uid, username, profileImage);
          emit(AddPostUpload());
        } catch (e) {
          emit(AddPostError(errorMessage: e.toString()));
        }
      }
    }
  }
}
