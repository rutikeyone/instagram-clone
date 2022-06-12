import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/bloc/comments_cubit/comments_cubit.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:instagram_clone/core/model/user.dart';
import 'package:instagram_clone/core/utils/mixin/show_post_simple_dialog.dart';
import 'package:instagram_clone/core/view_model/feed_post_view_model.dart';
import 'package:instagram_clone/presentation/widgets/more_actions_simple_dialog.dart';

import '../../widgets/post_item/post_item.dart';

class FeedPostInitial extends StatefulWidget with ShowSimpleDialog {
  final List<Post> posts;
  final User user;
  final FeedPostCubit feedPostCubit;
  final FeedPostViewModel feedPostViewModel;
  final CommentsCubit commentsCubit;
  const FeedPostInitial({
    Key? key,
    required this.user,
    required this.feedPostCubit,
    required this.feedPostViewModel,
    required this.posts,
    required this.commentsCubit,
  }) : super(key: key);

  @override
  State<FeedPostInitial> createState() => _FeedPostInitialState();
}

class _FeedPostInitialState extends State<FeedPostInitial> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _createFeedPostInitialAppBar(context),
        body: ListView.builder(
            itemCount: widget.posts.length,
            itemBuilder: (context, index) {
              return PostItem(
                onMorePressed: () => widget.showSimpleDialog(
                    context,
                    MoreActionsSimpleDialog(
                        postId: widget.posts[index].postId,
                        isCanDelete:
                            widget.posts[index].uid == widget.user.uid),
                    () {}),
                isLiked: widget.posts[index].likes.contains(widget.user.uid),
                onNotLikePressed: () => widget.feedPostCubit.notLikePost(
                    widget.posts[index].postId,
                    widget.user.uid,
                    widget.posts[index].likes),
                onLikePressed: () => widget.feedPostCubit.likePost(
                    widget.posts[index].postId,
                    widget.user.uid,
                    widget.posts[index].likes),
                post: widget.posts[index],
                onCommentsPressed: () => widget.feedPostViewModel
                    .navigateToComments(
                        context, widget.commentsCubit, widget.posts[index]),
              );
            }),
      ),
    );
  }

  AppBar _createFeedPostInitialAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: false,
      title: SvgPicture.asset(
        'assets/ic_instagram.svg',
        color: Theme.of(context).primaryColor,
        height: 32,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.messenger_outline,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    //widget.feedPostCubit.dispose();
    super.dispose();
  }
}
