//UPLOAD BUTTON
import 'package:flutter/material.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class UploadButton extends StatefulWidget {
  const UploadButton({super.key});

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 54,
        width: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: JColors.primaryColor,
        ),
        child: const Center(
            child: Text('Upload',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: JColors.white))),
      ),
    );
  }
}
