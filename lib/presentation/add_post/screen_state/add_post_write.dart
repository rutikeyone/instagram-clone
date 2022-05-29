import 'dart:io';
import 'package:flutter/material.dart';
import 'package:instagram_clone/generated/l10n.dart';
import '../../../core/bloc/add_post/add_post_cubit.dart';

class AddPostWrite extends StatelessWidget {
  final String imagePath;
  final AddPostCubit addPostCubit;
  const AddPostWrite(
      {Key? key, required this.imagePath, required this.addPostCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _postAddBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 10),
                ImagePostFile(imagePath: imagePath),
                const SizedBox(height: 10),
                const PostFormTextField(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  AppBar _postAddBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        child: const Icon(Icons.arrow_back_ios_new),
        onTap: () => addPostCubit.goToAddPostUpload(),
      ),
      title: Text(S.of(context).post_to),
      actions: [
        TextButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              S.of(context).post,
            ),
          ),
        ),
      ],
    );
  }
}

class PostFormTextField extends StatelessWidget {
  const PostFormTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        decoration: InputDecoration(
            hintText: S.of(context).write_a_caption, border: InputBorder.none),
        maxLines: 10,
      ),
    );
  }
}

class ImagePostFile extends StatelessWidget {
  const ImagePostFile({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imagePath),
      width: 300,
      height: 300,
    );
  }
}
