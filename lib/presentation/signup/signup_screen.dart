import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart';
import 'package:instagram_clone/core/model/email.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/widgets/input_text_field_type_one.dart';
import '../../core/model/password.dart';

class SignupScreen extends StatelessWidget {
  final SignupCubit signupCubit;
  const SignupScreen({Key? key, required this.signupCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: ((context, state) {}),
      child: const SignupPage(),
    );
  }
}

class SignupPage extends StatelessWidget {
  const SignupPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return WillPopScope(
      onWillPop: () async {
        cubit.clear();
        Navigator.of(context).pop();
        return false;
      },
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
                            SizedBox(height: 24),
                            _InstagramSvgPicture(),
                            SizedBox(height: 24),
                            _AddAvatar(),
                            SizedBox(height: 24),
                            _UserNameInputTextField(),
                            SizedBox(height: 24),
                            _EmailInputTextField(),
                            SizedBox(height: 24),
                            _PasswordInputTextField(),
                            SizedBox(height: 24),
                            _BioInputTextField(),
                            SizedBox(height: 24),
                            _SignUpButton(),
                            SizedBox(height: 24),
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

class _AddAvatar extends StatelessWidget {
  const _AddAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SignupCubit>();
    return Stack(
      children: [
        CircleAvatar(
          radius: 64,
          backgroundImage: cubit.state.file == null
              ? const AssetImage(
                  "assets/default_logo_avatar.png",
                )
              : MemoryImage(cubit.state.file!) as ImageProvider,
        ),
        Positioned(
          bottom: -10,
          left: 80,
          child: IconButton(
            onPressed: () async => cubit.pickImage(),
            icon: const Icon(
              Icons.add_a_photo,
            ),
          ),
        )
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          if (cubit.validate()) {
            cubit.signUp();
            cubit.clear();
            Navigator.of(context).pop();
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(S.of(context).sign_up),
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
    final cubit = context.watch<SignupCubit>();
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: ((previous, current) => previous.username != current.username),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.next,
          onChanged: (value) => cubit.onUsernameChanged(value),
          isError: state.username.invalid,
          autofocus: false,
          hintText: S.of(context).username,
          errorText: S.of(context).the_username_validate_message_1,
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
    final cubit = context.watch<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: ((previous, current) => previous.password != current.password),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.next,
          onChanged: (value) => cubit.onPasswordChanged(value),
          isError: state.password.invalid,
          autofocus: false,
          hintText: S.of(context).password,
          errorText: state.password.error == PasswordValidationError.empty
              ? S.of(context).the_password_validate_message_1
              : (state.password.error ==
                      PasswordValidationError.lessThanSixElements
                  ? S.of(context).the_password_validate_message_2
                  : ""),
          obscureText: true,
        );
      },
    );
  }
}

class _EmailInputTextField extends StatelessWidget {
  const _EmailInputTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: ((previous, current) => previous.email != current.email),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.next,
          onChanged: (value) => cubit.onEmailChanged(value),
          isError: state.email.invalid,
          autofocus: false,
          hintText: S.of(context).email,
          errorText: state.email.error == EmailValidationError.empty
              ? S.of(context).the_email_validate_message_1
              : (state.email.error == EmailValidationError.notEmail
                  ? S.of(context).the_email_validate_message_2
                  : ""),
          obscureText: false,
        );
      },
    );
  }
}

class _BioInputTextField extends StatelessWidget {
  const _BioInputTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: ((previous, current) => previous.bio != current.bio),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.done,
          onChanged: (value) => cubit.onBioChanged(value),
          isError: state.bio.invalid,
          autofocus: false,
          hintText: S.of(context).bio,
          errorText: S.of(context).the_bio_validate_message_1,
          obscureText: false,
        );
      },
    );
  }
}
