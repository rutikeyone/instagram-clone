import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/model/post.dart';

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
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 4, bottom: 4, left: 16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                              posts[index].profImage,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            posts[index].username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert)),
                        ],
                      ),
                    ),
                    Image.network(
                      posts[index].postUrl,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 4, bottom: 4, left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
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
                          const SizedBox(height: 4),
                          Text(
                            '${posts[index].likes.length} likes',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
