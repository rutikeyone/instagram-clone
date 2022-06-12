import 'package:flutter/material.dart';

class StatWidget extends StatelessWidget {
  final String message;
  final String label;
  const StatWidget({
    Key? key,
    required this.message,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
