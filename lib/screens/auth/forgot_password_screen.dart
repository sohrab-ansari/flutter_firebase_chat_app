// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/utils/app_button.dart';
import 'package:firebase_tutorial/utils/app_colors.dart';
import 'package:firebase_tutorial/utils/app_text.dart';
import 'package:firebase_tutorial/utils/app_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: AppColors.background),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (screenWidth * 0.05).clamp(14.0, 18.0).toDouble(),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: (screenHeight * 0.05).clamp(24.0, 40.0).toDouble(),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: "Forgot password",
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 10),
                    AppText(
                      text:
                          "Please enter your email \n to recover your email account",
                      fontSize: 15,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    AppTextField(
                      controller: emailController,
                      hintText: "Enter your email",
                    ),
                    SizedBox(height: 40),
                    AppButton(
                      text: "Forgot password",
                      onPressed: () {
                        auth
                            .sendPasswordResetEmail(
                              email: emailController.text.toString(),
                            )
                            .then((value) {
                              "Forgot password";
                            })
                            .onError((error, stackTrace) {
                              print(error.toString());
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
