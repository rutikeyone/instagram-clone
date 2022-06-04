import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart'
    as feed_post_cubit;
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/presentation/feed_post/screen_state/feed_post_initial.dart';
import 'package:instagram_clone/presentation/feed_post/screen_state/feed_post_loading.dart';

class FeedPostScreen extends StatelessWidget {
  const FeedPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<feed_post_cubit.FeedPostCubit,
            feed_post_cubit.FeedPostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is feed_post_cubit.FeedPostInitial) {
            final List<Post> _posts = state.posts ?? [];
            return FeedPostInitial(
              posts: _posts,
            );
          }

          if (state is feed_post_cubit.FeedPostLoading) {
            return const FeedPostLoading();
          }

          return Container();
        });
  }
}
