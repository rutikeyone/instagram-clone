import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final ImagePicker _picker = ImagePicker();
  AddPostCubit() : super(AddPostUpload());

  void closeAlertDialog(BuildContext context) async {
    Navigator.of(context).pop();
    emit(AddPostUpload());
  }

  void goToAddPostUpload() {
    emit(AddPostUpload());
  }

  void showAlertDialog() {
    emit(AddPostShowAlertDialog());
  }

  void addPostWithPhoto(ImageSource imageSource) async {
    final file = await _picker.pickImage(source: imageSource);

    if (file != null) {
      emit(AddPostWrite(imagePath: file.path));
    } else {
      emit(AddPostUpload());
    }
  }
}
