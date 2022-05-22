import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart'
    as signup_cubit;
import 'package:instagram_clone/core/model/email.dart';
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/widgets/input_text_field_type_one.dart';

import '../../../core/model/password.dart';

class SignupInitial extends StatefulWidget {
  final signup_cubit.SignupInitial initialState;
  final signup_cubit.SignupCubit cubit;
  const SignupInitial({
    Key? key,
    required this.initialState,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SignupInitial> createState() => _SignupInitialState();
}

class _SignupInitialState extends State<SignupInitial> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        children: [
                          const SizedBox(height: 24),
                          const _InstagramSvgPicture(),
                          const SizedBox(height: 24),
                          _AddAvatar(
                              cubit: widget.cubit,
                              initialState: widget.initialState),
                          const SizedBox(height: 24),
                          _UserNameInputTextField(
                              cubit: widget.cubit,
                              initialState: widget.initialState),
                          const SizedBox(height: 24),
                          _EmailInputTextField(
                              cubit: widget.cubit,
                              initialState: widget.initialState),
                          const SizedBox(height: 24),
                          _PasswordInputTextField(
                              cubit: widget.cubit,
                              initialState: widget.initialState),
                          const SizedBox(height: 24),
                          _BioInputTextField(
                              cubit: widget.cubit,
                              initialState: widget.initialState),
                          const SizedBox(height: 24),
                          _SignUpButton(cubit: widget.cubit),
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
      ),
    );
  }
}

class _AddAvatar extends StatelessWidget {
  final signup_cubit.SignupInitial initialState;
  final signup_cubit.SignupCubit cubit;
  const _AddAvatar({
    Key? key,
    required this.initialState,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 64,
          backgroundImage: initialState.file == null
              ? const AssetImage(
                  "assets/default_logo_avatar.png",
                )
              : MemoryImage(initialState.file!) as ImageProvider,
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
  final signup_cubit.SignupCubit cubit;
  const _SignUpButton({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => cubit.signUp(),
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
  final signup_cubit.SignupInitial initialState;
  final signup_cubit.SignupCubit cubit;
  const _UserNameInputTextField({
    Key? key,
    required this.initialState,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<signup_cubit.SignupCubit, signup_cubit.SignState>(
      buildWhen: ((previous, current) =>
          initialState.username != initialState.username),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.next,
          onChanged: (value) => cubit.onUsernameChanged(value),
          isError: initialState.username.invalid,
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
  final signup_cubit.SignupInitial initialState;
  final signup_cubit.SignupCubit cubit;
  const _PasswordInputTextField({
    Key? key,
    required this.cubit,
    required this.initialState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<signup_cubit.SignupCubit, signup_cubit.SignState>(
      buildWhen: ((previous, current) =>
          initialState.password != initialState.password),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.next,
          onChanged: (value) => cubit.onPasswordChanged(value),
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

class _EmailInputTextField extends StatelessWidget {
  final signup_cubit.SignupInitial initialState;
  final signup_cubit.SignupCubit cubit;
  const _EmailInputTextField({
    required this.initialState,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<signup_cubit.SignupCubit, signup_cubit.SignState>(
      buildWhen: ((previous, current) =>
          initialState.email != initialState.email),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.next,
          onChanged: (value) => cubit.onEmailChanged(value),
          isError: initialState.email.invalid,
          autofocus: false,
          hintText: S.of(context).email,
          errorText: initialState.email.error == EmailValidationError.empty
              ? S.of(context).the_email_validate_message_1
              : (initialState.email.error == EmailValidationError.notEmail
                  ? S.of(context).the_email_validate_message_2
                  : ""),
          obscureText: false,
        );
      },
    );
  }
}

class _BioInputTextField extends StatelessWidget {
  final signup_cubit.SignupInitial initialState;
  final signup_cubit.SignupCubit cubit;
  const _BioInputTextField({
    Key? key,
    required this.initialState,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<signup_cubit.SignupCubit, signup_cubit.SignState>(
      buildWhen: ((previous, current) => initialState.bio != initialState.bio),
      builder: (context, state) {
        return InputTextFieldTypeOne(
          textInputAction: TextInputAction.done,
          onChanged: (value) => cubit.onBioChanged(value),
          isError: initialState.bio.invalid,
          autofocus: false,
          hintText: S.of(context).bio,
          errorText: S.of(context).the_bio_validate_message_1,
          obscureText: false,
        );
      },
    );
  }
}
