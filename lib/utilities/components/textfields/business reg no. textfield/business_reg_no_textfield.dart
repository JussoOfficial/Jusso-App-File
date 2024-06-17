import 'package:flutter/material.dart';

class BusinessRegNoTextfield extends StatefulWidget {
  const BusinessRegNoTextfield({super.key});

  @override
  State<BusinessRegNoTextfield> createState() => _BusinessRegNoTextfieldState();
}

class _BusinessRegNoTextfieldState extends State<BusinessRegNoTextfield> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: 'Business Registration Number',
        hintText: 'Enter your Business Registration Number',
      ),
    );
  }
}
