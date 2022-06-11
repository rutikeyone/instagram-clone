import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/bloc/add_post_cubit/add_post_cubit.dart'
    as add_post_cubit;
import 'package:instagram_clone/generated/l10n.dart';

class AddPostSimpleDialog extends StatelessWidget {
  const AddPostSimpleDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
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
          onPressed: () => BlocProvider.of<add_post_cubit.AddPostCubit>(context)
              .closeAlertDialog(context),
        )
      ],
    );
  }
}
