import 'package:flutter/material.dart';

class AddPostError extends StatelessWidget {
  final String errorMessage;
  const AddPostError({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(errorMessage),
        ),
      ),
    );
  }
}
