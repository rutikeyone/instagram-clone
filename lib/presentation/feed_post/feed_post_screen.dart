import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart'
    as feed_post_cubit;
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart' as model;
import 'package:instagram_clone/core/model/user.dart';
import 'package:instagram_clone/presentation/feed_post/screen_state/feed_post_initial.dart';

import '../../core/utils/mixin/receive_authorized_user.dart';

class FeedPostScreen extends StatelessWidget with ReceiveAuthorizedUser {
  final feed_post_cubit.FeedPostCubit feedPostCubit;
  FeedPostScreen({Key? key, required this.feedPostCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<feed_post_cubit.FeedPostCubit,
        feed_post_cubit.FeedPostState>(builder: (context, state) {
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: feedPostCubit.postsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Post> posts =
                  snapshot.data!.docs.map((e) => Post.fromSnapshot(e)).toList();
              return FutureBuilder<User?>(
                  future: receiveUser(),
                  builder: (context, snapshot) {
                    final user = snapshot.data ?? const model.User.empty();
                    return FeedPostInitial(
                      feedPostCubit: feedPostCubit,
                      posts: posts,
                      user: user,
                    );
                  });
            }
            return Container();
          });
    });
  }
}
