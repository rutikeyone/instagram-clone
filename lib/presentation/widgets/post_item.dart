import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../core/model/post.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({
    Key? key,
    required this.post,
  }) : super(key: key);

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
                    imageUrl: post.profImage,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                post.username,
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
        CachedNetworkImage(
          placeholder: (context, url) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            color: Theme.of(context).focusColor,
          ),
          imageUrl: post.postUrl,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
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
                            text: "${post.username} ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: post.description,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${post.likes.length} ${S.of(context).likes}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              post.likes.isNotEmpty
                  ? InkWell(
                      child: Container(
                        padding: const EdgeInsets.only(top: 2, bottom: 4),
                        child: Text(
                          S.of(context).view_all_comments,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      onTap: () {},
                    )
                  : Container(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  DateFormat.yMMMd().format(post.datePublished),
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
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
