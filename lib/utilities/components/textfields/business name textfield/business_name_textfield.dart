import 'package:flutter/material.dart';

class BusinessNameTextfield extends StatefulWidget {
  const BusinessNameTextfield({super.key});

  @override
  State<BusinessNameTextfield> createState() => _BusinessNameTextfieldState();
}

class _BusinessNameTextfieldState extends State<BusinessNameTextfield> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: 'Business  Name',
        hintText: 'Enter your Business  Name',
      ),
    );
  }
}
