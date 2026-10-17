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
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: AppColors.background),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
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
    );
  }
}
