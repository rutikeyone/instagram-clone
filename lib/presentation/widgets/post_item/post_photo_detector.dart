import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/presentation/widgets/like_animation.dart';

class PostPhotoDetector extends StatelessWidget {
  final VoidCallback onLikeTap;
  final String imageUrl;
  final bool isLikeAnimating;
  final void Function()? onEndAnimation;
  const PostPhotoDetector({
    Key? key,
    required this.onLikeTap,
    required this.imageUrl,
    required this.isLikeAnimating,
    required this.onEndAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onLikeTap,
      child: Stack(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).focusColor,
            ),
            height: MediaQuery.of(context).size.height * 0.35,
            imageUrl: imageUrl,
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
                onEnd: onEndAnimation,
                child: const Icon(
                  Icons.favorite,
                  size: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
