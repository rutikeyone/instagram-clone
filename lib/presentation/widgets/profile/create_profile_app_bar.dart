import 'package:flutter/material.dart';
import 'package:instagram_clone/core/model/user.dart';

AppBar createProfileAppBar(BuildContext context, User user) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Text(
      user.username,
    ),
    centerTitle: false,
  );
}
