// ignore_for_file: equal_keys_in_map, constant_identifier_names

import 'package:firebase_tutorial/screens/auth/forgot_password_screen.dart';
import 'package:firebase_tutorial/screens/auth/login_screen.dart';
import 'package:firebase_tutorial/screens/auth/signup_screen.dart';
import 'package:firebase_tutorial/screens/chat/chat_screen.dart';
import 'package:firebase_tutorial/screens/home_screen.dart';
import 'package:firebase_tutorial/screens/main_screen.dart';
import 'package:firebase_tutorial/screens/profile/profile_screen.dart';
import 'package:firebase_tutorial/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String forgotPassword = '/forgot';
  static const String mainScreen = '/mainScreen';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    login: (context) =>  LoginScreen(),
    signup: (context) =>  SignupScreen(),
    forgotPassword: (context) =>  ForgotPasswordScreen(),
    mainScreen: (context) =>  MainScreen(),
    profile: (context) => const ProfileScreen(),
  };
}