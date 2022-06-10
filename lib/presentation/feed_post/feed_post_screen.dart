import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/comments_cubit/comments_cubit.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart'
    as feed_post_cubit;
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart' as model;
import 'package:instagram_clone/core/view_model/feed_post_view_model.dart';
import 'package:instagram_clone/presentation/feed_post/screen_state/feed_post_initial.dart';
import 'package:instagram_clone/presentation/feed_post/screen_state/feed_post_loading.dart';
import 'package:provider/provider.dart';

class FeedPostScreen extends StatelessWidget {
  final model.User user;
  const FeedPostScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FeedPostViewModel(),
      child: BlocConsumer<feed_post_cubit.FeedPostCubit,
              feed_post_cubit.FeedPostState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is feed_post_cubit.FeedPostInitial) {
              final List<Post> posts = state.posts ?? [];
              return FeedPostInitial(
                commentsCubit: BlocProvider.of<CommentsCubit>(context),
                feedPostViewModel: context.watch<FeedPostViewModel>(),
                user: user,
                feedPostCubit:
                    BlocProvider.of<feed_post_cubit.FeedPostCubit>(context),
                posts: posts,
              );
            }

            if (state is feed_post_cubit.FeedPostLoading) {
              return const FeedPostLoading();
            }

            return Container();
          }),
    );
  }
}
