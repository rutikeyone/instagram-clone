part of 'add_post_cubit.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

class AddPostUpload extends AddPostState {}

class AddPostShowAlertDialog extends AddPostState {}

class AddPostWrite extends AddPostState {
  final String imagePath;

  const AddPostWrite({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}
