import 'package:flutter/material.dart';

typedef EndCallback = void Function();

class ShowSimpleDialog {
  void showAlertDialog(
      BuildContext context, Widget widget, EndCallback endCallback) {
    showDialog(
      context: context,
      builder: (context) => widget,
    ).whenComplete(() => endCallback());
  }
}
