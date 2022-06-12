import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/profile_cubit/profile_cubit.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart';
import 'package:instagram_clone/core/navigation/route_generator.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/search/body_state/posts_body.dart';
import 'package:instagram_clone/presentation/widgets/profile_button_type_one.dart';
import 'package:instagram_clone/presentation/widgets/stat_widget.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileCubit profileCubit;
  const ProfileScreen({Key? key, required this.profileCubit}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    widget.profileCubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSignOut) {
          Navigator.of(context).pushReplacementNamed(loginRouteName);
        }
      },
      buildWhen: (prevState, nextState) => nextState is! ProfileSignOut,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: _createProfileAppBar(context, state),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ProfileAvatar(user: state.user),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                ProfileStat(
                                  posts: state.posts,
                                  user: state.user,
                                ),
                                ProfileButtonTypeOne(
                                    text: S.of(context).sign_out,
                                    onPressed: () =>
                                        widget.profileCubit.signOut()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ProfileUsername(username: state.user.username),
                      ProfileBio(
                        bio: state.user.bio,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(child: PostsBody(posts: state.posts)),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _createProfileAppBar(BuildContext context, ProfileState state) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        state.user.username,
      ),
      centerTitle: false,
    );
  }
}

class ProfileStat extends StatelessWidget {
  final User user;
  final List<Post> posts;
  const ProfileStat({
    Key? key,
    required this.user,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatWidget(
            message: posts.length.toString(), label: S.of(context).posts),
        StatWidget(
            message: user.followers.length.toString(),
            label: S.of(context).followers),
        StatWidget(
            message: user.following.length.toString(),
            label: S.of(context).following),
      ],
    );
  }
}

class ProfileBio extends StatelessWidget {
  final String bio;

  const ProfileBio({
    Key? key,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        top: 1,
      ),
      child: Text(
        bio,
      ),
    );
  }
}

class ProfileUsername extends StatelessWidget {
  final String username;
  const ProfileUsername({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Text(
        username,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final User user;
  const ProfileAvatar({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.fromSize(
        size: const Size.fromRadius(40),
        child: user.photoUrl.isNotEmpty
            ? CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Theme.of(context).focusColor,
                ),
                imageUrl: user.photoUrl,
              )
            : Container(
                color: Theme.of(context).focusColor,
              ),
      ),
    );
  }
}
