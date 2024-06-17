import 'package:flutter/material.dart';

class EmailTextfield extends StatefulWidget {
  const EmailTextfield({super.key});

  @override
  State<EmailTextfield> createState() => _EmailTextfieldState();
}

class _EmailTextfieldState extends State<EmailTextfield> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: 'Email',
        hintText: 'Enter your email',
      ),
    );
  }
}
