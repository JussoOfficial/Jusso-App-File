import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/inbox/screens/messages/chatscreen.dart';

class UserChatCard extends StatelessWidget {
  final String userName;
  final String chatPreview;
  final String chatDate;

  const UserChatCard(
      {super.key,
      required this.userName,
      required this.chatPreview,
      required this.chatDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //NAVIGATE TO CHAT SCREEN
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                chatPreview,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                chatDate,
                style: const TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
