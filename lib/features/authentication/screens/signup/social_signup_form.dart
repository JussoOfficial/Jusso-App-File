import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jusso_2024_file/common/common_widgets.dart';
import 'package:jusso_2024_file/features/authentication/controllers/sign_up_controller.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:jusso_2024_file/utils/validators/validate.dart';

class SocialUserForm extends StatefulWidget {
  const SocialUserForm({Key? key}) : super(key: key);

  @override
  State<SocialUserForm> createState() => _SocialUserFormState();
}

class _SocialUserFormState extends State<SocialUserForm> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  TextStyle labelStyle = const TextStyle();

  File? _image;

  String labelText = '';

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

  void _signUpSocialUser() {
    final SignUpController signUpController = SignUpController();
    signUpController.signUpSocialUser(
      emailcontroller.text,
      passwordcontroller.text,
      usernamecontroller.text,
      biocontroller.text,
      _image!,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 223, 220, 220),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 223, 220, 220),
          title: const Text('Social User Form'),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Please fill out the User Form'),
                ),
                const SizedBox(
                  height: 120,
                ),

                // PROFILE PICTURE
                Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: CircleAvatar(
                      radius: 81,
                      backgroundColor: JColors.primaryColor,
                      child: _image != null
                          ? ClipOval(
                              child: Image.file(
                                _image!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.person_add_alt,
                                color: Colors.black,
                                size: 72,
                              ),
                            ),
                    ),
                  ),
                ),
                // SIGN UP TEXTFIELDS

                // EMAIL TEXT FIELD
                Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: emailTextFormField(
                    emailcontroller: emailcontroller,
                    labelText: 'Email',
                    validator: Validators.validateEmail,
                    hintText: 'hintText',
                    labelStyle: labelStyle,
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                // USERNAME TEXT FIELD
                Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: usernameTextFormField(
                    usernamecontroller: usernamecontroller,
                    labelText: labelText,
                    validator: Validators.validateUsername,
                  ),
                ),

                // BIO TEXT FIELD
                Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: bioTextFormField(
                    biocontroller: biocontroller,
                    labelText: labelText,
                    validator: Validators.validateBio,
                  ),
                ),

                // PASSWORD TEXT FIELD
                Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: passwordTextFormField(
                    passwordcontroller: passwordcontroller,
                    labelText: labelText,
                    validator: Validators.validatePassword,
                    labelStyle: labelStyle,
                  ),
                ),
                // SIGN UP BUTTON
                Padding(
                  padding: EdgeInsets.all(21.0),
                  child: SignUpButton(
                    onPressed: _signUpSocialUser,
                  ),
                ),
                const SizedBox(
                  height: 1000,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
