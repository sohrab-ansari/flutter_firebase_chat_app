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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/icons/app_icon.png",
              height: 200,
              width: 400,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 40),
          Text(
            "Welcome to social media app",
            style: TextStyle(
              fontSize: 30,
              color: AppColors.buttonText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
