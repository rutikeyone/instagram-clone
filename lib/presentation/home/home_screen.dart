import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/bloc/cubit/profile_cubit.dart';
import 'package:instagram_clone/core/bloc/home_cubit/home_cubit.dart'
    as home_cubit;
import 'package:instagram_clone/core/bloc/search_cubit/search_cubit.dart';
import 'package:instagram_clone/presentation/home/screen_state/home_initial.dart';
import 'package:instagram_clone/presentation/home/screen_state/home_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<home_cubit.HomeCubit, home_cubit.HomeState>(
      builder: ((context, state) {
        if (state is home_cubit.HomeLoading) {
          return const HomeLoading();
        }

        if (state is home_cubit.HomeInitial) {
          return HomeInitial(
            profileCubit: BlocProvider.of<ProfileCubit>(context),
            searchCubit: BlocProvider.of<SearchCubit>(context),
            user: state.user,
            homeCubit: BlocProvider.of<home_cubit.HomeCubit>(context),
            initialState: state,
          );
        }

        return Container();
      }),
    );
  }
}
