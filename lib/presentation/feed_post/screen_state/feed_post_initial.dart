import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/model/post.dart';
import '../../widgets/post_item.dart';

class FeedPostInitial extends StatelessWidget {
  final List<Post> posts;
  const FeedPostInitial({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _createFeedPostInitialAppBar(context),
        body: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostItem(
                post: posts[index],
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
}
