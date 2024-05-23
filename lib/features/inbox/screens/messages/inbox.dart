import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/inbox/screens/notifications/notifications.dart';
import 'package:jusso_2024_file/features/inbox/widgets/userchat_card.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Inbox',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const NotificationScreen())); // Navigate to notifications screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Text(
              'Messages',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  //MESSAGES
                  //USER CHAT CARD
                  UserChatCard(
                      userName: 'User Name',
                      chatPreview: 'Preview of message',
                      chatDate: 'Date'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
