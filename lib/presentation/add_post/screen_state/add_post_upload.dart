import 'package:flutter/material.dart';
import 'package:instagram_clone/core/bloc/add_post_cubit/add_post_cubit.dart';

class AddPostUpload extends StatelessWidget {
  final AddPostCubit addPostCubit;
  const AddPostUpload({
    Key? key,
    required this.addPostCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: IconButton(
        icon: const Icon(Icons.upload, size: 32),
        onPressed: () => addPostCubit.showAlertDialog(),
      )),
    ));
  }
}
