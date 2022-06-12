import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/feed_post_cubit/feed_post_cubit.dart';
import 'package:instagram_clone/core/bloc/home_cubit/home_cubit.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart'
    as login_cubit;
import 'package:instagram_clone/core/navigation/route_generator.dart';
import 'package:instagram_clone/core/view_model/login_view_model.dart';
import 'package:instagram_clone/presentation/login/screen_state/login_initial.dart';
import 'package:instagram_clone/presentation/login/screen_state/login_loading.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: WillPopScope(
        onWillPop: () async {
          BlocProvider.of<login_cubit.LoginCubit>(context).emitBack();
          return true;
        },
        child: BlocConsumer<login_cubit.LoginCubit, login_cubit.LoginState>(
          listener: ((context, state) {
            if (state is login_cubit.LoginCreateUser) {
              Navigator.of(context).pushNamed(signupRouteName);
              BlocProvider.of<login_cubit.LoginCubit>(context)
                  .emitLoginInitial();
            }

            if (state is login_cubit.LoginUserFailure) {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                barrierDismissible: false,
                title: S.of(context).error,
                text: state.errorMessage,
                confirmBtnText: S.of(context).done,
              ).whenComplete(() =>
                  BlocProvider.of<login_cubit.LoginCubit>(context)
                      .emitLoginInitial());
            }

            if (state is login_cubit.LoginUserSuccess) {
              Navigator.of(context).pushReplacementNamed(homeRouteName);
              BlocProvider.of<login_cubit.LoginCubit>(context)
                  .emitLoginInitial();
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
                  homeCubit: context.watch<HomeCubit>(),
                  loginViewModel: context.read<LoginViewModel>(),
                  feedPostCubit: context.watch<FeedPostCubit>(),
                  initialState: state,
                  loginCubit: context.watch<login_cubit.LoginCubit>());
            }

            if (state is login_cubit.LoginUserLoading) {
              return const LoginLoading();
            }

            return Container();
          },
        ),
      ),
    );
  }
}
