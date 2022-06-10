import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/bloc/comments_cubit/comments_cubit.dart';
import 'package:instagram_clone/core/navigation/route_generator.dart';

import '../model/post.dart';

class FeedPostViewModel extends ChangeNotifier {
  void navigateToComments(
      BuildContext context, CommentsCubit commentsCubit, Post post) async {
    commentsCubit.establishUser().whenComplete(() {
      commentsCubit.establishPost(post);
      commentsCubit.listenCommentItem();
      Navigator.of(context).pushNamed(commentsRouteName);
    });
  }
}
