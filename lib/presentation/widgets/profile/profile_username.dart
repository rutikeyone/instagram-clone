import 'package:flutter/material.dart';

class ProfileUsername extends StatelessWidget {
  final String username;
  const ProfileUsername({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Text(
        username,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
