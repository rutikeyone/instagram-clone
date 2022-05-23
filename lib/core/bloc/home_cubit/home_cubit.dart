import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/core/model/user.dart' as model;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirebaseAuth _auth;
  final PageController homeController;

  HomeCubit()
      : _auth = FirebaseAuth.instance,
        homeController = PageController(),
        super(HomeLoading());

  void fetchAuthChanges() async {
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final user = model.User.fromMap(data);
    emit(HomeInitial(user: user, pageIndex: 0));
  }

  void changePageIndex(int newPageIndex) {
    if (state is HomeInitial) {
      final initialState = state as HomeInitial;
      homeController.jumpToPage(newPageIndex);
      emit(initialState.copyWith(pageIndex: newPageIndex));
    }
  }

  @override
  Future<void> close() {
    homeController.dispose();
    return super.close();
  }
}
