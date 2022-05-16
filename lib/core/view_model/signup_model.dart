import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart';

class SignupModel extends ChangeNotifier {
  final SignupCubit cubit;

  SignupModel({required this.cubit});

  void signUp(BuildContext context) async {
    await cubit.signUp().then((value) {
      if (value != null && value) {
        Navigator.of(context).pop();
      }
    });
  }

  void back(BuildContext context) {
    cubit.clear();
    Navigator.of(context).pop();
  }
}
