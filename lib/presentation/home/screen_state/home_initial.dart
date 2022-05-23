import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/bloc/home_cubit/home_cubit.dart'
    as home_cubit;
import 'package:instagram_clone/core/model/user.dart';
import 'package:instagram_clone/presentation/add_post/add_post_screen.dart';

class HomeInitial extends StatelessWidget {
  final User user;
  final home_cubit.HomeCubit homeCubit;
  final home_cubit.HomeInitial initialState;
  const HomeInitial({
    Key? key,
    required this.user,
    required this.homeCubit,
    required this.initialState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: homeCubit.homeController,
          children: const [
            Text("A"),
            Text("B"),
            AddPostScreen(),
            Text("D"),
            Text("E"),
          ],
        ),
        bottomNavigationBar: HomeInitialBottomNavigationBar(
          homeCubit: homeCubit,
          initialState: initialState,
        ),
      ),
    );
  }
}

class HomeInitialBottomNavigationBar extends StatelessWidget {
  final home_cubit.HomeCubit homeCubit;
  final home_cubit.HomeInitial initialState;
  const HomeInitialBottomNavigationBar({
    Key? key,
    required this.homeCubit,
    required this.initialState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      currentIndex: initialState.pageIndex,
      onTap: (index) => homeCubit.changePageIndex(index),
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            color: Theme.of(context).primaryColor,
          ),
          icon: Icon(
            Icons.home,
            color: Theme.of(context).focusColor,
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          icon: Icon(
            Icons.search,
            color: Theme.of(context).focusColor,
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.add_circle,
            color: Theme.of(context).primaryColor,
          ),
          icon: Icon(
            Icons.add_circle,
            color: Theme.of(context).focusColor,
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.favorite,
            color: Theme.of(context).primaryColor,
          ),
          icon: Icon(
            Icons.favorite,
            color: Theme.of(context).focusColor,
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
          ),
          icon: Icon(
            Icons.person,
            color: Theme.of(context).focusColor,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
