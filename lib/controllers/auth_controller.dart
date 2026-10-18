// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, strict_top_level_inference

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial/controllers/session_controller.dart';
import 'package:firebase_tutorial/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  // DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');

  DatabaseReference ref = FirebaseDatabase.instanceFor(
  app: FirebaseAuth.instance.app,
  databaseURL: 'https://flutter-firebase-2298a-default-rtdb.firebaseio.com/',
).ref().child('users');

  bool _isLoading = false;
  bool get Loading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


// signup
  void signUp(
    BuildContext context,
    String username,
    String email,
    String password,
  ) async {
    setLoading(true);

    try {
      final user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            value.user!.updateDisplayName(username);

            SessionController().userId = auth.currentUser!.uid.toString();
            ref.child(value.user!.uid.toString()).set({
              'uid': value.user!.uid.toString(),
              // 'userName': value.user!.displayName.toString(),
              'userName': username,

              'email': value.user!.email.toString(),
              'phone': value.user!.phoneNumber.toString(),
              'onlineStatus': 'NoOne',
              'profileImage': '',
            });
            Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
            setLoading(false);
          })
          .onError((error, stackTrace) {
            setLoading(false);
          });
    } catch (e) {
      setLoading(false);

      print(e.toString());
    }
  }

  // Login

  void login(BuildContext context, String email, String password) async {
    setLoading(true);
    final user = await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          SessionController().userId = auth.currentUser!.uid.toString();

          Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
          setLoading(false);
        })
        .onError((error, stackTrace) {
          setLoading(false);
        });

    try {} catch (e) {
      setLoading(false);

      print(e.toString());
    }
  }
}
