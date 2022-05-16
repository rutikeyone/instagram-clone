import 'package:flutter/material.dart';
import 'package:instagram_clone/presentation/login/login_screen.dart';
import 'package:instagram_clone/presentation/signup/signup_screen.dart';

const loginRouteName = '/login';
const signupRouteName = '/signup';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case loginRouteName:
        return MaterialPageRoute(
          builder: ((context) => const LoginScreen()),
        );
      case signupRouteName:
        return MaterialPageRoute(
          builder: ((context) => const SignupScreen()),
        );
      default:
        _errorRoute;
    }
    return _errorRoute();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("ERROR"),
        )),
  );
}
