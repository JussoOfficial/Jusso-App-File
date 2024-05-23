import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Row(
            children: [
              CircleAvatar(
                  // Add user avatar here
                  ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style:
                        TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          elevation: 3,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  // Add your chat messages here
                  ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.deepOrange),
                    onPressed: () {
                      // Add send message functionality here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
