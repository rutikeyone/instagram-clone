import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/favourite_cubit/favourite_cubit.dart';
import 'package:instagram_clone/core/model/user.dart';
import 'package:instagram_clone/core/utils/mixin/receive_authorized_user.dart';
import 'package:instagram_clone/presentation/search/body_state/posts_body.dart';

import '../../core/model/post.dart';

class FavouriteScreen extends StatelessWidget with ReceiveAuthorizedUser {
  final FavouriteCubit favouriteCubit;
  FavouriteScreen({Key? key, required this.favouriteCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: favouriteCubit.postsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Post> posts = snapshot.data!.docs
                      .map((e) => Post.fromSnapshot(e))
                      .toList();
                  return FutureBuilder<User?>(
                    future: receiveUser(),
                    builder: (context, snapshot) {
                      final user = snapshot.data ?? const User.empty();
                      final sortedPosts = posts
                          .where((element) => element.likes.contains(user.uid))
                          .toList();
                      return PostsBody(posts: sortedPosts);
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}
