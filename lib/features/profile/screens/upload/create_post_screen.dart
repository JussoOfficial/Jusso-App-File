import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/features/dashboard/screens/dashboard.dart';
import 'package:jusso_2024_file/features/profile/controllers/upload_controller.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class CreatePostScreen extends StatelessWidget {
  final File file;
  final TextEditingController descriptionController = TextEditingController();
  final Uint8List? thumbnail;

  CreatePostScreen({Key? key, required this.file, this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Create Post',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
                image: thumbnail != null
                    ? DecorationImage(
                        image: MemoryImage(thumbnail!),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: FileImage(file),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Initialize the UploadController and pass required parameters
                UploadController uploadController = UploadController(
                  file: file,
                  thumbnail: thumbnail ?? Uint8List(0),
                  description: descriptionController.text,
                );

                // Upload the file using the initialized UploadController
                await uploadController.uploadFile(
                    file: file, description: descriptionController.text);

                // Clear the description controller
                descriptionController.clear();

                // Navigate to the DashboardPage
                Get.offAll(
                  DashboardPage(initialIndex: 2),
                  transition: Transition.fade,
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: JColors.primaryColor,
              ),
              child: Text(
                'Upload',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: JColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
