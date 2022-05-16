import 'package:flutter/material.dart';

class InputTextFieldTypeOne extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final String errorText;
  final bool isError;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool autofocus;
  final void Function(String)? onSubmitted;
  const InputTextFieldTypeOne({
    Key? key,
    this.textEditingController,
    required this.hintText,
    required this.isError,
    required this.textInputAction,
    required this.autofocus,
    required this.onChanged,
    required this.errorText,
    required this.obscureText,
    this.keyboardType,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
        errorText: isError ? errorText : null,
        hintText: hintText,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
    );
  }
}
