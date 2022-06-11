import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/presentation/widgets/post_item/post_item.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    Key? key,
    required this.widget,
    required this.isCanDelete,
    required this.onMorePressed,
  }) : super(key: key);

  final PostItem widget;
  final bool isCanDelete;
  final VoidCallback onMorePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                imageUrl: widget.post.profileImage,
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
            onPressed: () => widget.isCanDelete ? widget.onMorePressed() : null,
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
