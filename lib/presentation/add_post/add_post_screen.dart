import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/add_post_cubit/add_post_cubit.dart'
    as add_post_cubit;
import 'package:instagram_clone/core/utils/mixin/show_post_simple_dialog.dart';
import 'package:instagram_clone/presentation/add_post/screen_state/add_post_error.dart';
import 'package:instagram_clone/presentation/add_post/screen_state/add_post_loading.dart';
import 'package:instagram_clone/presentation/add_post/screen_state/add_post_write.dart';
import 'package:instagram_clone/presentation/add_post/screen_state/add_post_upload.dart';

import '../widgets/add_post_simple_dialog.dart';

class AddPostScreen extends StatelessWidget with ShowSimpleDialog {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<add_post_cubit.AddPostCubit,
        add_post_cubit.AddPostState>(
      listener: (context, state) {
        if (state is add_post_cubit.AddPostShowAlertDialog) {
          showSimpleDialog(
              context,
              const AddPostSimpleDialog(),
              BlocProvider.of<add_post_cubit.AddPostCubit>(context)
                  .emitAddPostUpload);
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
}
