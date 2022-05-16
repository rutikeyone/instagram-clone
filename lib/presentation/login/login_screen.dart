import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/widgets/input_text_field_type_one.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: ((context, state) {}),
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SafeArea(
              child: Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            _InstagramSvgPicture(),
                            SizedBox(height: 64),
                            _UserNameInputTextField(),
                            SizedBox(height: 24),
                            _PasswordInputTextField(),
                            SizedBox(height: 24),
                            _LogInButton(),
                            SizedBox(height: 12),
                            _SignUp(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUp extends StatelessWidget {
  const _SignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(S.of(context).don_t_have_an_account),
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => cubit.navigationInSignUp(context),
          child: Container(
            child: Text(
              S.of(context).sign_up,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }
}

class _LogInButton extends StatelessWidget {
  const _LogInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(S.of(context).log_in),
        ),
        onPressed: () => cubit.loginWithUserNameAndPassword(),
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
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

class _UserNameInputTextField extends StatelessWidget {
  const _UserNameInputTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: ((previous, current) => previous.username != current.username),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.next,
          onChanged: (value) => cubit.onUsernameChanged(value),
          isError: state.username.invalid,
          autofocus: false,
          hintText: S.of(context).username_or_email,
          errorText: S.of(context).the_login_or_password_validate_message_1,
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}

class _PasswordInputTextField extends StatelessWidget {
  const _PasswordInputTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: ((previous, current) => previous.password != current.password),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.done,
          onChanged: (value) => cubit.onPasswordChanged(value),
          isError: state.password.invalid,
          autofocus: false,
          hintText: S.of(context).password,
          errorText: S.of(context).the_password_validate_message_1,
          obscureText: true,
        );
      },
    );
  }
}
