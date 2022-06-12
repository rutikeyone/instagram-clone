import 'package:flutter/material.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/widgets/post_item/post_actions.dart';
import 'package:instagram_clone/presentation/widgets/post_item/post_description.dart';
import 'package:instagram_clone/presentation/widgets/post_item/post_header.dart';
import 'package:instagram_clone/presentation/widgets/post_item/post_photo_detector.dart';
import 'package:instagram_clone/presentation/widgets/post_item/view_all_container.dart';
import '../../../core/model/post.dart';
import 'date_published_container.dart';

class PostItem extends StatefulWidget {
  final Post post;
  final bool isLiked;
  final VoidCallback onLikePressed;
  final VoidCallback onNotLikePressed;
  final VoidCallback onCommentsPressed;
  final VoidCallback onMorePressed;

  const PostItem({
    Key? key,
    required this.onLikePressed,
    required this.isLiked,
    required this.onNotLikePressed,
    required this.onMorePressed,
    required this.post,
    required this.onCommentsPressed,
  }) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool _isDisposed = false;
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostHeader(
          onMorePressed: widget.onMorePressed,
          widget: widget,
        ),
        PostPhotoDetector(
          onLikeTap: () {
            if (widget.isLiked && !_isDisposed) {
              setState(() {
                isLikeAnimating = !isLikeAnimating;
                widget.onLikePressed();
              });
            }
          },
          imageUrl: widget.post.postUrl,
          isLikeAnimating: isLikeAnimating,
          onEndAnimation: () {
            if (!_isDisposed) {
              setState(() {
                isLikeAnimating = false;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostActions(
                isLiked: widget.isLiked,
                onLikePressed: () {
                  widget.onLikePressed();
                  if (!_isDisposed) {
                    setState(() {
                      isLikeAnimating = !isLikeAnimating;
                    });
                  }
                },
                onNotLikePressed: () {
                  widget.onNotLikePressed();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostDescription(widget: widget),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.post.likes.length} ${S.of(context).likes}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              ViewAllCommentsContainer(onTap: () => widget.onCommentsPressed()),
              DatePublishedContainer(widget: widget),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
