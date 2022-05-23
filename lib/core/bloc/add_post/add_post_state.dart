part of 'add_post_cubit.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

class AddPostUpload extends AddPostState {}

class AddPostShowAlertDialog extends AddPostState {}

class AddPost extends AddPostState {}
