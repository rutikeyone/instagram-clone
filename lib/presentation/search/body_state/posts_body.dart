import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/model/post.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PostsBody extends StatelessWidget {
  final List<Post> posts;
  const PostsBody({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 3,
      itemCount: posts.length,
      itemBuilder: (context, index) => CachedNetworkImage(
        placeholder: (context, url) => Container(
          color: Theme.of(context).focusColor,
        ),
        imageUrl: posts[index].postUrl,
        fit: BoxFit.cover,
      ),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}
