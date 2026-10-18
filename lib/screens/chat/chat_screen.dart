// ignore_for_file: unused_local_variable, unused_field

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial/controllers/session_controller.dart';
import 'package:firebase_tutorial/utils/app_colors.dart';
import 'package:firebase_tutorial/utils/app_text.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String name, image, email, receiverId;

  const ChatScreen({
    super.key,
    required this.name,
    required this.image,
    required this.email,
    required this.receiverId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('message');
  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white, size: 30),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Expanded(
            //   child: FirebaseAnimatedList(
            //     query: ref,
            //     controller: _scrollController,
            //     itemBuilder: (context, snapshot, animation, index) {
            //       String message =
            //           snapshot.child('message').value?.toString() ?? '';
            //       final sender =
            //           snapshot.child('sender').value?.toString() ?? '';

            //       final receiver =
            //           snapshot.child('receiver').value?.toString() ?? '';

            //       final myId = SessionController().userId.toString();

            //       final isThisChat =
            //           (sender == myId && receiver == widget.receiverId) ||
            //           (sender == widget.receiverId && receiver == myId);

            //       if (!isThisChat) {
            //         return const SizedBox.shrink();
            //       }

            //       final isMe = sender == SessionController().userId.toString();

            //       final timestamp = int.tryParse(
            //         snapshot.child('time').value?.toString() ?? '',
            //       );

            //       final time = timestamp == null
            //           ? ''
            //           : TimeOfDay.fromDateTime(
            //               DateTime.fromMicrosecondsSinceEpoch(timestamp),
            //             ).format(context);

            //       return SizeTransition(
            //         sizeFactor: animation,

            //         child: Align(
            //           alignment: isMe
            //               ? Alignment.centerRight
            //               : Alignment.centerLeft,
            //           child: Container(
            //             margin: EdgeInsets.symmetric(
            //               horizontal: 12,
            //               vertical: 5,
            //             ),
            //             padding: const EdgeInsets.all(12),
            //             decoration: BoxDecoration(
            //               color: isMe
            //                   ? AppColors.primaryColor
            //                   : AppColors.navigationUnselected,
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             child: Column(
            //               children: [
            //                 Text(
            //                   message,
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     color: AppColors.buttonText,
            //                   ),
            //                 ),

            //                 AppText(
            //                   text: time,
            //                   fontSize: 10,
            //                   color: AppColors.buttonText,
            //                   textAlign: TextAlign.left,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: StreamBuilder<DatabaseEvent>(
                stream: ref.orderByChild('time').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.data!.snapshot;
                  final messages = data.children.where((item) {
                    final sender = item.child('sender').value.toString();
                    final receiver = item.child('receiver').value.toString();
                    final myId = SessionController().userId.toString();

                    // final timestamp = int.tryParse(
                    //   data.child('time').value?.toString() ?? '',
                    // );

                    return (sender == myId && receiver == widget.receiverId) ||
                        (sender == widget.receiverId && receiver == myId);
                  }).toList();

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final item = messages[messages.length - 1 - index];

                      final message =
                          item.child('message').value?.toString() ?? '';

                      final sender =
                          item.child('sender').value?.toString() ?? '';

                      final isMe =
                          sender == SessionController().userId.toString();

                      final timestamp = int.tryParse(
                        item.child('time').value?.toString() ?? '',
                      );

                      final time = timestamp == null
                          ? ''
                          : TimeOfDay.fromDateTime(
                              DateTime.fromMicrosecondsSinceEpoch(timestamp),
                            ).format(context);

                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: screenWidth * 0.75,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isMe
                                ? AppColors.primaryColor
                                : AppColors.textHint,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: message,
                                color: isMe ? Colors.white : Colors.black,
                                fontSize: 14,
                              ),
                              SizedBox(height: 5),
                              AppText(
                                text: time,
                                color: isMe ? Colors.white : Colors.black,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              color: AppColors.background,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                      onSubmitted: (_) => sendMessage(),
                    ),
                  ),

                  const SizedBox(width: 8),

                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SEND MESSAGE
  void sendMessage() async {
    if (messageController.text.trim().isEmpty) {
      return;
    } else {
      final timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
      try {
        await ref.child(timeStamp).set({
          'isSeen': false,
          'message': messageController.text.toString(),
          'sender': SessionController().userId.toString(),
          'receiver': widget.receiverId,
          'type': 'text',
          'time': timeStamp,
        });

        debugPrint('Message sent successfully');
        messageController.clear();
      } catch (e) {
        debugPrint('Firebase error: $e');
      }
    }
  }
}
