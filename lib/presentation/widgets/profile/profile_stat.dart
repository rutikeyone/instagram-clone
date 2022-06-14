import 'package:flutter/material.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/widgets/stat_widget.dart';

class ProfileStat extends StatelessWidget {
  final int countPosts;
  final int countFollowers;
  final int countFollowing;
  const ProfileStat({
    Key? key,
    required this.countPosts,
    required this.countFollowers,
    required this.countFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatWidget(message: countPosts.toString(), label: S.of(context).posts),
        StatWidget(
            message: countFollowers.toString(), label: S.of(context).followers),
        StatWidget(
            message: countFollowing.toString(), label: S.of(context).following),
      ],
    );
  }
}
