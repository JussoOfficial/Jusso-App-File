//CREATE POST BUTTON
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jusso_2024_file/features/profile/screens/upload/upload_screen.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class CreatePostButton extends StatelessWidget {
  Future<void> _openGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);

    String filePath = pickedFile?.path ?? pickedVideo?.path ?? '';

    if (filePath.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UploadScreen(file: File(filePath))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openGallery(context),
      child: Container(
        height: 54,
        width: 108,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: JColors.primaryColor,
        ),
        child: Center(
          child: Text(
            'Create Post',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
