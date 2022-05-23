import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/add_post/add_post_cubit.dart'
    as add_post_cubit;
import 'package:instagram_clone/presentation/add_post/screen_state/add_post.dart';
import 'package:instagram_clone/presentation/add_post/screen_state/add_post_upload.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<add_post_cubit.AddPostCubit,
        add_post_cubit.AddPostState>(
      listener: (context, state) {
        if (state is add_post_cubit.AddPostShowAlertDialog) {
          BlocProvider.of<add_post_cubit.AddPostCubit>(context).emitAddPost();
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

        if (state is add_post_cubit.AddPost) {
          return const AddPost();
        }

        return Container();
      },
    );
  }
}
