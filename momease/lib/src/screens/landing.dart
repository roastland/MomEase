import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:momease/injection_container.dart';
import 'package:momease/src/core/navigation_bar/cubit/custom_navigation_bar_cubit.dart';
import 'package:momease/src/core/navigation_bar/custom_navigation_bar.dart';
import 'package:momease/src/core/settings/settings_view.dart';
import 'package:momease/src/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:momease/src/features/community/presentation/bloc/community_bloc.dart';
import 'package:momease/src/features/community/presentation/bloc/community_details_post_bloc.dart';
import 'package:momease/src/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:momease/src/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:momease/src/features/therapy/presentation/bloc/therapy_bloc.dart';
import 'package:momease/src/screens/pages/community_page.dart';
import 'package:momease/src/screens/pages/home_page.dart';
import 'package:momease/src/screens/pages/journal_page.dart';
import 'package:momease/src/screens/pages/profile_page.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  final List<Widget> _pages = const [
    HomePage(),
    JournalPage(),
    CommunityPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomNavigationBarCubit>(
            create: (context) => sl<CustomNavigationBarCubit>()),
        BlocProvider<TherapyBloc>(create: (context) => sl<TherapyBloc>()),
        BlocProvider<ExerciseBloc>(create: (context) => sl<ExerciseBloc>()),
        BlocProvider<ArticlesBloc>(create: (context) => sl<ArticlesBloc>()),
        BlocProvider<CommunityBloc>(create: (context) => sl<CommunityBloc>()),
        BlocProvider<CommunityDetailsPostBloc>(
            create: (context) => sl<CommunityDetailsPostBloc>()),
        BlocProvider<JournalBloc>(create: (context) => sl<JournalBloc>()),
      ],
      child: BlocConsumer<CustomNavigationBarCubit, CustomNavigationBarState>(
        listener: (context, state) {
          //Toast Are You Sure You Want to Exit
          if (state is CustomNavigationBarAreYouSureYouWantToExit) {
            Fluttertoast.showToast(
              msg: "Press Back Again to Exit",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              // backgroundColor: badButtonColor,
              // textColor: buttonTextColor,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          int currentIndex =
              context.read<CustomNavigationBarCubit>().stateToIndex(state);

          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: SizedBox(
                    height: 24,
                    child: Image.asset('./assets/images/momease_logo.png'),
                  ),
                  // backgroundColor: const Color(0xFF1A87FF),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      // TODO: Change this navigator, not using routename
                      onPressed: () {
                        // Navigate to the settings page. If the user leaves and returns
                        // to the app after it has been killed while running in the
                        // background, the navigation stack is restored.
                        Navigator.restorablePushNamed(
                            context, SettingsView.routeName);
                      },
                    ),
                  ],
                ),
                body: _pages[currentIndex],
                bottomNavigationBar: const CustomNavigationBar(),
              ),
            ],
          );
        },
      ),
    );
  }
}
