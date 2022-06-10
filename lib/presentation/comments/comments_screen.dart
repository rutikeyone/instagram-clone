import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/comments_cubit/comments_cubit.dart'
    as comments_cubit;
import 'package:instagram_clone/presentation/comments/screen_state/comments_initial.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<comments_cubit.CommentsCubit,
        comments_cubit.CommentsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is comments_cubit.CommentsInitial) {
          return CommentsInitial(
            initialState: state,
            user: state.user,
            commentsCubit:
                BlocProvider.of<comments_cubit.CommentsCubit>(context),
          );
        }

        return Container();
      },
    );
  }
}
