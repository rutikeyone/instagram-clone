import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/model/user.dart';

class HomeInitial extends StatelessWidget {
  final User user;
  const HomeInitial({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(user.email),
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
              ),
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.person,
              ),
              label: '',
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
