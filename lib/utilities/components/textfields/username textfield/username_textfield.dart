import 'package:flutter/material.dart';

class UsernameTextfield extends StatefulWidget {
  const UsernameTextfield({super.key});

  @override
  State<UsernameTextfield> createState() => _UsernameTextfieldState();
}

class _UsernameTextfieldState extends State<UsernameTextfield> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: 'Username',
        hintText: 'Enter your username',
      ),
    );
  }
}
