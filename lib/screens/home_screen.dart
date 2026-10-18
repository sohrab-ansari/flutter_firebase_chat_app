// ignore_for_file: deprecated_member_use

import 'package:firebase_tutorial/screens/chat/chats_lists.dart';
import 'package:firebase_tutorial/utils/app_colors.dart';
import 'package:firebase_tutorial/utils/app_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final contentPadding = (screenWidth * 0.067).clamp(16.0, 24.0).toDouble();
    final iconPadding = (screenWidth * 0.083).clamp(20.0, 30.0).toDouble();
    final iconSize = (screenWidth * 0.28).clamp(80.0, 100.0).toDouble();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.background,
        title: const AppText(
          text: 'Synora',

          color: AppColors.primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(contentPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(iconPadding),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.10),
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: Image.asset(
                        'assets/icons/app_icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const AppText(
                    text: 'Welcome to Synora!',
                    textAlign: TextAlign.center,
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 12),
                  AppText(
                    text:
                        'Connect with your friends and family.\n'
                        'Send messages and stay connected.',
                    textAlign: TextAlign.center,

                    fontSize: 15,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: (screenHeight * 0.065).clamp(46.0, 52.0).toDouble(),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatsListsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chat_rounded, size: 24),
                      label: const AppText(
                        text: 'Start Chatting',

                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonText,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
