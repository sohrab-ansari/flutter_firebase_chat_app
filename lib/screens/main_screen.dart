// ignore_for_file: sort_child_properties_last, unused_field
import 'package:firebase_tutorial/screens/chat/chats_lists.dart';
import 'package:firebase_tutorial/screens/home_screen.dart';
import 'package:firebase_tutorial/screens/profile/profile_screen.dart';
import 'package:firebase_tutorial/utils/app_colors.dart';
import 'package:firebase_tutorial/utils/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

int selectedIndex = 0;

final List<Widget> screens = [
  const HomeScreen(),
  ChatsListsScreen(),
   ProfileScreen(),
];

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,

      bottom: true,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: IndexedStack(children: screens, index: selectedIndex),
        bottomNavigationBar: AppBottomNavigation(
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
