import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/bloc/login_cubit/login_cubit.dart';
import 'package:instagram_clone/core/model/user.dart' as model;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PageController homeController;
  final LoginCubit loginCubit;
  late final StreamSubscription loginSubscription;

  HomeCubit({required this.loginCubit})
      : homeController = PageController(),
        super(const HomeState(user: model.User.empty(), pageIndex: 0)) {
    loginSubscription =
        loginCubit.stream.listen((loginState) => _listenLoginCubit(loginState));
  }

  void _listenLoginCubit(LoginState loginState) {
    if (loginState is LoginUserSuccess) {
      emit(state.copyWith(user: state.user, pageIndex: 0));
    }
  }

  void changePageIndex(int newPageIndex) {
    homeController.jumpToPage(newPageIndex);
    emit(state.copyWith(pageIndex: newPageIndex));
  }

  @override
  Future<void> close() {
    homeController.dispose();
    return super.close();
  }
}
