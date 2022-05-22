import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart'
    as signup_cubit;
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/signup/state/signup_initial.dart';
import 'package:instagram_clone/presentation/signup/state/signup_loading.dart';

class SignupScreen extends StatefulWidget {
  final signup_cubit.SignupCubit signupCubit;
  const SignupScreen({Key? key, required this.signupCubit}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<signup_cubit.SignupCubit>(context).emitBack();
        BlocProvider.of<signup_cubit.SignupCubit>(context).emitSignupInitial();
        return false;
      },
      child: BlocConsumer<signup_cubit.SignupCubit, signup_cubit.SignState>(
        listener: ((context, state) {
          if (state is signup_cubit.SignBack) {
            Navigator.of(context).pop(true);
            BlocProvider.of<signup_cubit.SignupCubit>(context)
                .emitSignupInitial();
          }

          if (state is signup_cubit.SignCreateUserFailure) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              barrierDismissible: false,
              title: S.of(context).error,
              text: state.errorMessage,
              confirmBtnText: S.of(context).done,
            ).whenComplete(() =>
                BlocProvider.of<signup_cubit.SignupCubit>(context)
                    .emitSignupInitial());
          }
        }),
        buildWhen: (prevState, nextState) {
          return nextState is! signup_cubit.SignCreateUserFailure &&
              nextState is! signup_cubit.SignBack &&
              nextState is! signup_cubit.SignCreateUserSuccess;
        },
        builder: (context, state) {
          if (state is signup_cubit.SignupInitial) {
            return SignupInitial(
              initialState: state,
              cubit: context.watch<signup_cubit.SignupCubit>(),
            );
          }

          if (state is signup_cubit.SignCreateUserLoading) {
            return const SignupLoading();
          }

          return Container();
        },
      ),
    );
  }
}
