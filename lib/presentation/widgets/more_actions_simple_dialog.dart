import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart';
import 'package:instagram_clone/generated/l10n.dart';

class MoreActionsSimpleDialog extends StatelessWidget {
  final bool isCanDelete;
  final String postId;
  const MoreActionsSimpleDialog({
    Key? key,
    required this.isCanDelete,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(S.of(context).actions),
      children: <Widget>[
        isCanDelete
            ? SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Text(S.of(context).delete),
                onPressed: () {
                  BlocProvider.of<FeedPostCubit>(context).deletePost(postId);
                  Navigator.of(context).pop();
                })
            : Container(),
      ],
    );
  }
}
