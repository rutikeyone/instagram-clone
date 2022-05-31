part of 'add_post_cubit.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

class AddPostUpload extends AddPostState {}

class AddPostShowAlertDialog extends AddPostState {}

class AddPostWrite extends AddPostState {
  final PostValidate post;
  final FormzStatus status;
  final String imagePath;

  const AddPostWrite({
    required this.imagePath,
    this.post = const PostValidate.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [imagePath, post, status];

  AddPostWrite copyWith({
    PostValidate? post,
    FormzStatus? status,
    String? imagePath,
  }) {
    return AddPostWrite(
      post: post ?? this.post,
      status: status ?? this.status,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
