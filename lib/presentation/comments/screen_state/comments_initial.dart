import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/bloc/comments_cubit/comments_cubit.dart'
    as comments_cubit;
import 'package:instagram_clone/core/model/user.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/widgets/comment_card.dart';

class CommentsInitial extends StatefulWidget {
  final User user;
  final comments_cubit.CommentsCubit commentsCubit;
  final comments_cubit.CommentsInitial initialState;
  const CommentsInitial({
    Key? key,
    required this.user,
    required this.commentsCubit,
    required this.initialState,
  }) : super(key: key);

  @override
  State<CommentsInitial> createState() => _CommentsInitialState();
}

class _CommentsInitialState extends State<CommentsInitial> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.commentsCubit.clear();
        Navigator.of(context).pop();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(S.of(context).comments),
            leading: IconButton(
                onPressed: () {
                  widget.commentsCubit.clear();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          body: ListView.builder(
            itemCount: widget.initialState.comments.length,
            itemBuilder: ((context, index) =>
                CommentCard(comment: widget.initialState.comments[index])),
          ),
          bottomNavigationBar: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(16),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(
                        color: Theme.of(context).focusColor,
                      ),
                      imageUrl: widget.user.photoUrl,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: TextField(
                      onChanged: (value) =>
                          widget.commentsCubit.onCommentChanged(value),
                      decoration: InputDecoration(
                        hintText:
                            '${S.of(context).comments_as} ${widget.user.username}',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => widget.commentsCubit.postComment(),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Text(
                      S.of(context).post,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.commentsCubit.dispose();
    super.dispose();
  }
}
