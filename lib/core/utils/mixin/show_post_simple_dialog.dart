import 'package:flutter/material.dart';

typedef EndCallback = void Function();

class ShowSimpleDialog {
  void showSimpleDialog(
      BuildContext context, Widget widget, EndCallback endCallback) {
    showDialog(
      context: context,
      builder: (context) => widget,
    ).whenComplete(() => endCallback());
  }
}
