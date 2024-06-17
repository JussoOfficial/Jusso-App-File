import 'package:flutter/material.dart';

class BioTextfield extends StatefulWidget {
  const BioTextfield({super.key});

  @override
  State<BioTextfield> createState() => _BioTextfieldState();
}

class _BioTextfieldState extends State<BioTextfield> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: 'Bio  ',
        hintText: 'Enter your Bio  ',
      ),
    );
  }
}
