import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostUpload());

  void emitAddPost() {
    emit(AddPost());
  }

  void showAlertDialog() async {
    emit(AddPostShowAlertDialog());
  }
}
