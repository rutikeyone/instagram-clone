import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart';
import 'package:instagram_clone/core/get_it_locator/locator.dart';
import 'package:instagram_clone/presentation/home/home_screen.dart';
import 'package:instagram_clone/presentation/login/login_screen.dart';
import 'package:instagram_clone/presentation/signup/signup_screen.dart';

const loginRouteName = '/login';
const signupRouteName = '/signup';
const exitRouteName = '/exit';
const homeRouteName = '/homescreen';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case loginRouteName:
        return MaterialPageRoute(
          builder: ((context) => const LoginScreen()),
        );
      case signupRouteName:
        return MaterialPageRoute(
          builder: ((context) => SignupScreen(
                signupCubit: getIt.get<SignupCubit>(),
              )),
        );
      case homeRouteName:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
      case exitRouteName:
        return exit(0);
      default:
        return null;
    }
  }
}
