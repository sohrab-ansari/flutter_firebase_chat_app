// ignore_for_file: strict_top_level_inference

import 'dart:io';

import 'package:firebase_tutorial/controllers/session_controller.dart';
import 'package:firebase_tutorial/screens/profile/profile_screen.dart';
import 'package:firebase_tutorial/utils/app_colors.dart';
import 'package:firebase_tutorial/utils/app_text.dart';
import 'package:firebase_tutorial/utils/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController with ChangeNotifier {
  final picker = ImagePicker();

  final nameController = TextEditingController();
  final numberController = TextEditingController();

  File? _image;

  File? get image => _image;

  // PICK GALLERY IMAGE
  Future pickGalleryImage(BuildContext context) async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      notifyListeners();
    }
  }

  // PICK CAMERA IMAGE
  Future pickCameraImage(BuildContext context) async {
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      notifyListeners();
    }
  }

  // PICK IMAGE DIALOG BOX
  void pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: Material(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.image),
                    title: const Text("Gallery"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // EDIT NAME DIALOG

  Future<void> showNameDialog(BuildContext context, String name) async {
    nameController.text = name;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Center(
            child: AppText(
              text: "Update username",
              fontSize: 18,
              color: AppColors.primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                keyboardType: TextInputType.name,
                controller: nameController,
                hintText: 'Enter username',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: AppText(text: "Cancel", color: AppColors.error),
            ),
            TextButton(
              onPressed: () {
                ref.child(SessionController().userId.toString()).update({
                  'userName': nameController.text.toString(),
                });
                Navigator.pop(context);
                nameController.clear();
              },
              child: AppText(text: "Update", color: AppColors.primaryColor),
            ),
          ],
        );
      },
    );
  }


  // SHOW NUMBER UPDATE DIALOG

    Future<void> showNumberDialog(BuildContext context, String number) async {
    numberController.text = number;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Center(
            child: AppText(
              text: "Update number",
              fontSize: 18,
              color: AppColors.primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                
                controller: numberController,
                hintText: 'Enter number',
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: AppText(text: "Cancel", color: AppColors.error),
            ),
            TextButton(
              onPressed: () {
                ref.child(SessionController().userId.toString()).update({
                  'phone': numberController.text.toString(),
                });
                Navigator.pop(context);
                numberController.clear();
              },
              child: AppText(text: "Update", color: AppColors.primaryColor),
            ),
          ],
        );
      },
    );
  }


}
