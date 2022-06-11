import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart';
import 'package:instagram_clone/core/bloc/home_cubit/home_cubit.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart';

class LoginViewModel extends ChangeNotifier {
  void loginWithUserNameAndPassword(
      {required LoginCubit loginCubit,
      required HomeCubit homeCubit,
      required FeedPostCubit feedPostCubit}) async {
    await loginCubit.loginWithUserNameAndPassword().whenComplete(() async {
      if (loginCubit.state is LoginUserSuccess) {
        await homeCubit.fetchAuthChanges();
        await feedPostCubit.init();
      }
    });
  }
}
