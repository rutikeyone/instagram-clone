import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart';
import 'package:instagram_clone/core/bloc/home_cubit/home_cubit.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart'
    as login_cubit;
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/widgets/input_text_field_type_one.dart';

import '../../../core/validate_model/email_validate.dart';
import '../../../core/validate_model/password_validate.dart';
import '../../../core/view_model/login_view_model.dart';

class LoginInitial extends StatelessWidget {
  final login_cubit.LoginCubit loginCubit;
  final login_cubit.LoginInitial initialState;
  final LoginViewModel loginViewModel;
  final HomeCubit homeCubit;
  final FeedPostCubit feedPostCubit;

  const LoginInitial({
    Key? key,
    required this.loginCubit,
    required this.loginViewModel,
    required this.initialState,
    required this.feedPostCubit,
    required this.homeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        const _InstagramSvgPicture(),
                        const SizedBox(height: 64),
                        _EmailInputTextField(
                            loginCubit: loginCubit, initialState: initialState),
                        const SizedBox(height: 24),
                        _PasswordInputTextField(
                            loginCubit: loginCubit, initialState: initialState),
                        const SizedBox(height: 24),
                        _LogInButton(
                          homeCubit: homeCubit,
                          loginCubit: loginCubit,
                          feedPostCubit: feedPostCubit,
                          loginViewModel: loginViewModel,
                        ),
                        const SizedBox(height: 12),
                        _SignUp(
                            initialState: initialState, loginCubit: loginCubit),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUp extends StatelessWidget {
  final login_cubit.LoginCubit loginCubit;
  final login_cubit.LoginInitial initialState;
  const _SignUp({
    Key? key,
    required this.initialState,
    required this.loginCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Text(S.of(context).don_t_have_an_account),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => loginCubit.emitLoginCreareUser(),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Text(
              S.of(context).sign_up,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LogInButton extends StatelessWidget {
  final login_cubit.LoginCubit loginCubit;
  final FeedPostCubit feedPostCubit;
  final LoginViewModel loginViewModel;
  final HomeCubit homeCubit;
  const _LogInButton({
    Key? key,
    required this.loginViewModel,
    required this.loginCubit,
    required this.feedPostCubit,
    required this.homeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => loginViewModel.loginWithUserNameAndPassword(
            loginCubit: loginCubit,
            homeCubit: homeCubit,
            feedPostCubit: feedPostCubit),
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(S.of(context).log_in),
        ),
      ),
    );
  }
}

class _InstagramSvgPicture extends StatelessWidget {
  const _InstagramSvgPicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/ic_instagram.svg",
      color: Theme.of(context).primaryColor,
      height: 64,
    );
  }
}

class _EmailInputTextField extends StatelessWidget {
  final login_cubit.LoginInitial initialState;
  final login_cubit.LoginCubit loginCubit;
  const _EmailInputTextField({
    Key? key,
    required this.initialState,
    required this.loginCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<login_cubit.LoginCubit, login_cubit.LoginState>(
      buildWhen: ((previous, current) =>
          initialState.email != initialState.email),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.next,
          onChanged: (value) => loginCubit.onEmailChanged(value),
          isError: initialState.email.invalid,
          autofocus: false,
          hintText: S.of(context).email,
          errorText: initialState.email.error == EmailValidationError.empty
              ? S.of(context).the_email_validate_message_1
              : (initialState.email.error == EmailValidationError.notEmail
                  ? S.of(context).the_email_validate_message_2
                  : ""),
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}

class _PasswordInputTextField extends StatelessWidget {
  final login_cubit.LoginInitial initialState;
  final login_cubit.LoginCubit loginCubit;
  const _PasswordInputTextField({
    Key? key,
    required this.initialState,
    required this.loginCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<login_cubit.LoginCubit, login_cubit.LoginState>(
      buildWhen: ((previous, current) =>
          initialState.password != initialState.password),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.done,
          onChanged: (value) => loginCubit.onPasswordChanged(value),
          isError: initialState.password.invalid,
          autofocus: false,
          hintText: S.of(context).password,
          errorText:
              initialState.password.error == PasswordValidationError.empty
                  ? S.of(context).the_password_validate_message_1
                  : (initialState.password.error ==
                          PasswordValidationError.lessThanSixElements
                      ? S.of(context).the_password_validate_message_2
                      : ""),
          obscureText: true,
        );
      },
    );
  }
}
