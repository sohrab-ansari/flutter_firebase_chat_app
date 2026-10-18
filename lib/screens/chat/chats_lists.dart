// ignore_for_file: deprecated_member_use, non_constant_identifier_names, unused_local_variable, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tutorial/controllers/session_controller.dart';
import 'package:firebase_tutorial/screens/chat/chat_screen.dart';
import 'package:firebase_tutorial/utils/app_colors.dart';
import 'package:firebase_tutorial/utils/app_text.dart';
import 'package:flutter/material.dart';


class ChatsListsScreen extends StatefulWidget {
  const ChatsListsScreen({super.key});

  @override
  State<ChatsListsScreen> createState() => _ChatsListsScreenState();
}

class _ChatsListsScreenState extends State<ChatsListsScreen> {
  final _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('users');
  final searchController = TextEditingController();
  final updateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: AppText( text: 
          "Chats",
         fontSize: 24,
         color: AppColors.white,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: AppColors.white,
          onRefresh: () {
           return ref.get();
          },
          child: FirebaseAnimatedList(
            query: ref,
            defaultChild: const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            ),
            itemBuilder: (context, snapshot, animation, index) {
              if (SessionController().userId.toString() ==
                  snapshot.child('uid').value.toString()) {
                return Container();
              } else {
                return Card(
                  color: AppColors.background,
                  elevation: 0,
                  child: ListTile(
                    onTap: () {
                      BottomNavigationBarItem(icon: Icon(Icons.add));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            receiverId: snapshot.child('uid').value.toString(),
                            email: snapshot.child('email').value.toString(),
                            name: snapshot.child('userName').value.toString(),
                            image: snapshot.child('profile').value.toString(),
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                      radius: 25,
                      backgroundImage:
                          snapshot.child('profile').value != null &&
                              snapshot
                                  .child('profile')
                                  .value
                                  .toString()
                                  .isNotEmpty
                          ? NetworkImage(
                              snapshot.child('profile').value.toString(),
                            )
                          : null,
                      child:
                          snapshot.child('profile').value == null ||
                              snapshot.child('profile').value.toString().isEmpty
                          ? const Icon(Icons.person, size: 35)
                          : null,
                    ),
                    title: AppText(
                      text: snapshot.child('userName').value.toString(),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: AppText(
                      text: snapshot.child('email').value.toString(),
                      fontSize: 14,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),

      backgroundColor: AppColors.background,
    );
  }
}