import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/model/user.dart';

class ProfileAvatar extends StatelessWidget {
  final User user;
  const ProfileAvatar({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.fromSize(
        size: const Size.fromRadius(40),
        child: user.photoUrl.isNotEmpty
            ? CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Theme.of(context).focusColor,
                ),
                imageUrl: user.photoUrl,
              )
            : Container(
                color: Theme.of(context).focusColor,
              ),
      ),
    );
  }
}
