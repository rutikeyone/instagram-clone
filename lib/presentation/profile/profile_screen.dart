import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/profile_cubit/profile_cubit.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart';
import 'package:instagram_clone/core/navigation/route_generator.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/search/body_state/posts_body.dart';
import 'package:instagram_clone/presentation/widgets/profile/create_profile_app_bar.dart';
import 'package:instagram_clone/presentation/widgets/profile/profile_avatar.dart';
import 'package:instagram_clone/presentation/widgets/profile/profile_bio.dart';
import 'package:instagram_clone/presentation/widgets/profile/profile_stat.dart';
import 'package:instagram_clone/presentation/widgets/profile/profile_username.dart';
import 'package:instagram_clone/presentation/widgets/profile_button_type_one.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileCubit profileCubit;
  const ProfileScreen({Key? key, required this.profileCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      child: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: profileCubit.profileStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {}

              if (snapshot.connectionState == ConnectionState.active) {
                final mapData = snapshot.data!.data()!;
                final User user = User.fromMap(mapData);

                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: profileCubit.postsAuthorizedUserStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Post> posts = snapshot.data!.docs
                          .map((e) => Post.fromSnapshot(e))
                          .toList();
                      return Scaffold(
                        appBar: createProfileAppBar(context, user),
                        body: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ProfileAvatar(user: user),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            ProfileStat(
                                              countPosts: posts.length,
                                              countFollowers:
                                                  user.followers.length,
                                              countFollowing:
                                                  user.followers.length,
                                            ),
                                            ProfileButtonTypeOne(
                                              text: S.of(context).sign_out,
                                              onPressed: () => profileCubit
                                                  .signOut()
                                                  .whenComplete(
                                                    () => Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            loginRouteName),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  ProfileUsername(username: user.username),
                                  ProfileBio(
                                    bio: user.bio,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Expanded(child: PostsBody(posts: posts)),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                );
              }
              return Container();
            }),
      ),
    );
  }
}
