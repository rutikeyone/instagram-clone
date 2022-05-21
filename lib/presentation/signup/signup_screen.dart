import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/signup_cubit/signup_cubit.dart'
    as signup_cubit;
import 'package:instagram_clone/generated/l10n.dart';
import 'package:instagram_clone/presentation/signup/state/signup_initial.dart';
import 'package:instagram_clone/presentation/signup/state/signup_loading.dart';

class SignupScreen extends StatelessWidget {
  final signup_cubit.SignupCubit signupCubit;
  const SignupScreen({Key? key, required this.signupCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<signup_cubit.SignupCubit, signup_cubit.SignState>(
      listener: ((context, state) {
        if (state is signup_cubit.SignCreateUserSuccess) {
          Navigator.of(context).pop();
          BlocProvider.of<signup_cubit.SignupCubit>(context)
              .emitSignupInitial();
        }

        if (state is signup_cubit.SignCreateUserFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(state.errorMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(S.of(context).done),
                ),
              ],
            ),
          ).whenComplete(() =>
              BlocProvider.of<signup_cubit.SignupCubit>(context)
                  .emitSignupInitial());
        }
      }),
      buildWhen: (prevState, nextState) {
        return nextState is! signup_cubit.SignCreateUserFailure &&
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
    );
  }
}
