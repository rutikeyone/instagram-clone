import 'package:flutter/material.dart';

class ProfileBio extends StatelessWidget {
  final String bio;

  const ProfileBio({
    Key? key,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        top: 1,
      ),
      child: Text(
        bio,
      ),
    );
  }
}
