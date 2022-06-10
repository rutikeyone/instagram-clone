import 'package:flutter/material.dart';

class FeedPostLoading extends StatelessWidget {
  const FeedPostLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
