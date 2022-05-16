import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart';

class SignupModel extends ChangeNotifier {
  final SignupCubit cubit;

  SignupModel({required this.cubit});

  void back(BuildContext context) {
    cubit.clear();
    Navigator.of(context).pop();
  }
}
