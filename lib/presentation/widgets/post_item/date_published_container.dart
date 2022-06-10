import 'package:flutter/material.dart';
import 'package:instagram_clone/presentation/widgets/post_item/post_item.dart';
import 'package:intl/intl.dart';

class DatePublishedContainer extends StatelessWidget {
  const DatePublishedContainer({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final PostItem widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        DateFormat.yMMMd().format(widget.post.datePublished),
        style: TextStyle(
          color: Theme.of(context).focusColor,
        ),
      ),
    );
  }
}
