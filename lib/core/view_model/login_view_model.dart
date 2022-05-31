import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/bloc/home_cubit/home_cubit.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart';

class LoginViewModel extends ChangeNotifier {
  void loginWithUserNameAndPassword(
      LoginCubit loginCubit, HomeCubit homeCubit) async {
    await loginCubit.loginWithUserNameAndPassword();
    await homeCubit.fetchAuthChanges();
  }
}
