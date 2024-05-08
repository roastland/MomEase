import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/custom_navigation_bar_cubit.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    CustomNavigationBarState currentState =
        context.watch<CustomNavigationBarCubit>().state;
    int currentIndex =
        context.read<CustomNavigationBarCubit>().stateToIndex(currentState);

    CustomNavigationBarState? newstate;
    return PopScope(
      canPop: (newstate.runtimeType == CustomNavigationBarExit) ? true : false,
      onPopInvoked: (bool didPop) {
        newstate = context.read<CustomNavigationBarCubit>().popPage();
        // if (newstate.runtimeType == CustomNavigationBarExit) {
        //   return Future.value(true);
        // } else {
        //   return Future.value(false);
        // }
      },
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: const Color(0xFF1A87FF),
        // backgroundColor: primaryColor,
        // unselectedItemColor: unselectedItemColor,
        currentIndex: currentIndex,
        onTap: (index) {
          context.read<CustomNavigationBarCubit>().pushPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_color),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
