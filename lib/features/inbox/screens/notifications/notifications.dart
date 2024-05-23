import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/inbox/widgets/notifications.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Notifications',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 20), // Adding space above the text

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //NOTIFICATIONS CARD
              NotificationsCard(),
            ],
          ),
        ],
      ),
    );
  }
}
