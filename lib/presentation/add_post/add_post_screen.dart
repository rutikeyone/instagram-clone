import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/bloc/add_post/add_post_cubit.dart'
    as add_post_cubit;
import 'package:instagram_clone/core/model/user.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/add_post/screen_state/add_post_error.dart';
import 'package:instagram_clone/presentation/add_post/screen_state/add_post_loading.dart';
import 'package:instagram_clone/presentation/add_post/screen_state/add_post_write.dart';
import 'package:instagram_clone/presentation/add_post/screen_state/add_post_upload.dart';

class AddPostScreen extends StatelessWidget {
  final User user;
  const AddPostScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<add_post_cubit.AddPostCubit,
        add_post_cubit.AddPostState>(
      listener: (context, state) {
        if (state is add_post_cubit.AddPostShowAlertDialog) {
          _showPostAlertDialog(context);
        }
      },
      buildWhen: (prevState, nextState) {
        return nextState is! add_post_cubit.AddPostShowAlertDialog;
      },
      builder: (context, state) {
        if (state is add_post_cubit.AddPostUpload) {
          return AddPostUpload(
            addPostCubit: BlocProvider.of<add_post_cubit.AddPostCubit>(context),
          );
        }

        if (state is add_post_cubit.AddPostWrite) {
          return AddPostWrite(
            user: user,
            imagePath: state.imagePath,
            addPostCubit: BlocProvider.of<add_post_cubit.AddPostCubit>(context),
          );
        }

        if (state is add_post_cubit.AddPostLoading) {
          return const AddPostLoading();
        }

        if (state is add_post_cubit.AddPostError) {
          return AddPostError(errorMessage: state.errorMessage);
        }

        return Container();
      },
    );
  }

  void _showPostAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(S.of(context).create_a_post),
        children: <Widget>[
          SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Text(S.of(context).take_a_photo),
              onPressed: () async {
                Navigator.of(context).pop();
                BlocProvider.of<add_post_cubit.AddPostCubit>(context)
                    .addPostWithPhoto(ImageSource.camera);
              }),
          SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Text(S.of(context).choose_from_gallery),
              onPressed: () async {
                Navigator.of(context).pop();
                BlocProvider.of<add_post_cubit.AddPostCubit>(context)
                    .addPostWithPhoto(ImageSource.gallery);
              }),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: Text(S.of(context).cancel),
            onPressed: () =>
                BlocProvider.of<add_post_cubit.AddPostCubit>(context)
                    .closeAlertDialog(context),
          )
        ],
      ),
    );
  }
}
