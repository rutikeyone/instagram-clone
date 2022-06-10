import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onLikePressed;
  final VoidCallback onNotLikePressed;
  const PostActions({
    Key? key,
    required this.isLiked,
    required this.onLikePressed,
    required this.onNotLikePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        !isLiked
            ? IconButton(
                onPressed: onLikePressed,
                icon: const Icon(
                  Icons.favorite,
                ),
              )
            : IconButton(
                onPressed: onNotLikePressed,
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
    );
  }
}
