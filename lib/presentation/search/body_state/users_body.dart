import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/model/user.dart';

class UsersBody extends StatelessWidget {
  final List<User> users;
  const UsersBody({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
        child: Row(
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(16),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Theme.of(context).focusColor,
                  ),
                  imageUrl: users[index].photoUrl,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              users[index].username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
