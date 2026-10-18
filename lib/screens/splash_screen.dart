import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/controllers/session_controller.dart';
import 'package:firebase_tutorial/utils/app_colors.dart';
import 'package:firebase_tutorial/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final logoHeight = (screenHeight * 0.35).clamp(90.0, 200.0).toDouble();
    final logoWidth = screenWidth.clamp(180.0, 400.0).toDouble();
    final spacing = (screenHeight * 0.05).clamp(20.0, 40.0).toDouble();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/app_icon.png",
                height: logoHeight,
                width: logoWidth,
                fit: BoxFit.cover,
              ),
              SizedBox(height: spacing),
              Text(
                "Welcome to flutter chat app",
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.buttonText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
    );
  }

  void isLogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      SessionController().userId = user.uid.toString();
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
      });
    } else {
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
    }
  }
}
