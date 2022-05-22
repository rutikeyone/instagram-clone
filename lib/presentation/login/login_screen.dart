import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart'
    as login_cubit;
import 'package:instagram_clone/core/navigation/route_generator.dart';
import 'package:instagram_clone/presentation/login/state/login_initial.dart';
import 'package:instagram_clone/presentation/login/state/login_loading.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<login_cubit.LoginCubit>(context).emitBack();
        return true;
      },
      child: BlocConsumer<login_cubit.LoginCubit, login_cubit.LoginState>(
        listener: ((context, state) {
          if (state is login_cubit.LoginCreateUser) {
            Navigator.of(context).pushNamed(signupRouteName).whenComplete(() =>
                BlocProvider.of<login_cubit.LoginCubit>(context)
                    .emitLoginInitial());
          }

          if (state is login_cubit.LoginUserSuccess) {
            print("Success");
            BlocProvider.of<login_cubit.LoginCubit>(context).emitLoginInitial();
          }

          if (state is login_cubit.LoginBack) {
            Navigator.of(context).pushNamed(exitRouteName);
          }
        }),
        buildWhen: (prevState, nextState) =>
            nextState is! login_cubit.LoginCreateUser &&
            nextState is! login_cubit.LoginUserFailure &&
            nextState is! login_cubit.LoginUserSuccess &&
            nextState is! login_cubit.LoginBack,
        builder: (context, state) {
          if (state is login_cubit.LoginInitial) {
            return LoginInitial(
                initialState: state,
                loginCubit: context.watch<login_cubit.LoginCubit>());
          }

          if (state is login_cubit.LoginUserLoading) {
            return const LoginLoading();
          }

          return Container();
        },
      ),
    );
  }
}
