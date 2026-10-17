// ignore_for_file: deprecated_member_use

import 'package:firebase_tutorial/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const AppBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.015,
      ),
      child: GNav(
        hoverColor: AppColors.iconPrimary,
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
        textStyle: const TextStyle(color: AppColors.primaryColor),
        gap: 9,
        backgroundColor: AppColors.white,
        color: Colors.grey,
        activeColor: AppColors.primaryColor,
        tabBackgroundColor: AppColors.primaryColor.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.message_outlined, text: 'Chats'),
          GButton(icon: Icons.person_outline, text: 'Profile'),
        ],
      ),
    );
  }
}
