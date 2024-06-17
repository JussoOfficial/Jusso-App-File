import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield({super.key});

  @override
  State<PasswordTextfield> createState() => _EmailTextfieldState();
}

class _EmailTextfieldState extends State<PasswordTextfield> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: 'password',
        hintText: 'Enter your password',
      ),
    );
  }
}
