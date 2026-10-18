// ignore_for_file: use_super_parameters, must_be_immutable, public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial/controllers/profile/edit_profile_controller.dart';
import 'package:firebase_tutorial/utils/app_button.dart';
import 'package:firebase_tutorial/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:firebase_tutorial/controllers/session_controller.dart';
import 'package:firebase_tutorial/utils/app_colors.dart';
import 'package:firebase_tutorial/utils/app_text.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final ref = FirebaseDatabase.instance.ref('users');
final _auth = FirebaseAuth.instance;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (_) => EditProfileController(),
        child: Consumer<EditProfileController>(
          builder: (context, provider, child) {
            return StreamBuilder(
              stream: ref.child(SessionController().userId.toString()).onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data.snapshot.value;

                  if (data == null) {
                    return const Center(child: Text("User data not found"));
                  }

                  Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);

                  return SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: (screenHeight * 0.044)
                            .clamp(20.0, 35.0)
                            .toDouble(),
                        horizontal: (screenWidth * 0.042)
                            .clamp(12.0, 15.0)
                            .toDouble(),
                      ),
                      child: SingleChildScrollView(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColors.darkGray,
                                              width: 3,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              70,
                                            ),
                                            child: provider.image == null
                                                ? map['profileImage']
                                                              .toString() ==
                                                          ""
                                                      ? Icon(
                                                          Icons
                                                              .person_2_outlined,
                                                          size: 50,
                                                        )
                                                      : Image(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                            map['profileImage']
                                                                .toString(),
                                                          ),
                                                          loadingBuilder:
                                                              (
                                                                context,
                                                                child,
                                                                loadingProgress,
                                                              ) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  ),
                                                                );
                                                              },
                                                          errorBuilder:
                                                              (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) {
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  ),
                                                                );
                                                              },
                                                        )
                                                : Image.file(
                                                    File(
                                                      provider.image!.path,
                                                    ).absolute,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        provider.pickImage(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.primaryColor,
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                InkWell(
                                  onTap: () {
                                    provider.showNameDialog(
                                      context,
                                      map['userName'],
                                    );
                                  },
                                  child: ReUseableRow(
                                    iconData: Icons.person_2_outlined,
                                    title: "UserName",
                                    value: map['userName'],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.showNumberDialog(
                                      context,
                                      map['phone'].toString(),
                                    );
                                  },

                                  child: ReUseableRow(
                                    iconData: Icons.phone_outlined,
                                    title: "Phone",
                                    value: map['phone'] == null
                                        ? "xxx-xxx-xxx"
                                        : map['phone'].toString(),
                                  ),
                                ),
                                ReUseableRow(
                                  iconData: Icons.email_outlined,
                                  title: "Email",
                                  value: map['email'],
                                ),
                                SizedBox(height: 40),
                                AppButton(
                                  text: "Logout",
                                  onPressed: () {
                                    _auth.signOut();
                                    print("Logout Successfully");

                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.login,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: AppText(text: "Something went wrong", fontSize: 40),
                  );
                }
              },
            );
          },
        ),
      ),
      backgroundColor: AppColors.background,
    );
  }
}

class ReUseableRow extends StatelessWidget {
  String title, value;
  IconData iconData;
  ReUseableRow({
    Key? key,
    required this.title,
    required this.value,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        ListTile(
          leading: Icon(iconData),
          title: Text(title),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: (screenWidth * 0.45).clamp(80.0, 220.0).toDouble(),
            ),
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        Divider(color: AppColors.divider),
      ],
    );
  }
}
