import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../core/model/post.dart';
import 'like_animation.dart';

class PostItem extends StatefulWidget {
  final Post post;
  final String userUid;
  final VoidCallback onLikePressed;
  final VoidCallback onNotLikePressed;
  final VoidCallback onCommentsPressed;
  const PostItem({
    Key? key,
    required this.userUid,
    required this.onLikePressed,
    required this.onNotLikePressed,
    required this.post,
    required this.onCommentsPressed,
  }) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
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
                    imageUrl: widget.post.profImage,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.post.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            if (!widget.post.likes.contains(widget.userUid)) {
              setState(() {
                isLikeAnimating = !isLikeAnimating;
                widget.onLikePressed();
              });
            }
          },
          child: Stack(
            children: [
              CachedNetworkImage(
                placeholder: (context, url) => Container(
                  color: Theme.of(context).focusColor,
                ),
                height: MediaQuery.of(context).size.height * 0.35,
                imageUrl: widget.post.postUrl,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  !widget.post.likes.contains(widget.userUid)
                      ? IconButton(
                          onPressed: () {
                            widget.onLikePressed();
                            setState(() {
                              isLikeAnimating = !isLikeAnimating;
                            });
                          },
                          icon: const Icon(
                            Icons.favorite,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            widget.onNotLikePressed();
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                  IconButton(
                    icon: const Icon(
                      Icons.comment_outlined,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                    ),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                          TextSpan(
                            text: "${widget.post.username} ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: widget.post.description,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.post.likes.length} ${S.of(context).likes}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: widget.onCommentsPressed,
                child: Container(
                  padding: const EdgeInsets.only(top: 2, bottom: 4),
                  child: Text(
                    S.of(context).view_all_comments,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
