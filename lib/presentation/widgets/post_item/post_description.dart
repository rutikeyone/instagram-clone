import 'package:flutter/material.dart';
import 'package:instagram_clone/presentation/widgets/post_item/post_item.dart';

class PostDescription extends StatelessWidget {
  const PostDescription({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final PostItem widget;

  @override
  Widget build(BuildContext context) {
    return RichText(
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
    );
  }
}
