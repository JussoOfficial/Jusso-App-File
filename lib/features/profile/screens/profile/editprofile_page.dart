import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jusso_2024_file/features/profile/controllers/edit_profile_controller.dart';
import 'package:jusso_2024_file/features/profile/models/edit_profile_model.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:jusso_2024_file/utils/validators/validate.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? _image;
  final EditProfileController _editProfileController =
      Get.put(EditProfileController());

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveProfile() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        final profile = EditProfileModel(
          profileImage: '', // Empty for now
          username: usernameController.text.trim(),
          bio: bioController.text.trim(),
        );

        // Injected controller called to update the profile
        await _editProfileController.updateUserProfile(profile, imageFile);

        // Clear text fields and reset image
        usernameController.clear();
        bioController.clear();

        setState(() {
          _image = null;
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(21.0),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Column(
                    children: [
                      Text('Edit Profile Picture',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(height: 10),
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 239, 233, 233),
                        radius: 81,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(81),
                                child: Image.file(
                                  _image!,
                                  width: 162,
                                  height: 162,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(Icons.person_add_alt_1,
                                size: 81, color: JColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(),
              const Text('Edit Profile Username and Bio',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: Validators.validateUsername,
                ),
              ),
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: bioController,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                  ),
                  validator: Validators.validateBio,
                ),
              ),
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JColors.primaryColor,
                  ),
                  onPressed: _saveProfile,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
