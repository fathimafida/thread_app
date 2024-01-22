import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/common/cubit/main_cubit.dart';
import 'package:thread_app/features/create_thread/create_thread.dart';

import 'package:thread_app/features/home/views/home_view.dart';
import 'package:thread_app/features/profile/profile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pages = [HomeView(), CreateThread(), ProfileView()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, int>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: currentIndex,
              onTap: (index) {
                // context.read<MainCubit>().changeIndex(index);
                currentIndex = index;
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit_calendar_rounded),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "",
                ),
              ]),
          body: _pages[state],
        );
      },
    );
  }
}
