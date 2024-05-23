import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jusso_2024_file/common/common_widgets.dart';
import 'package:jusso_2024_file/features/authentication/controllers/sign_up_controller.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:jusso_2024_file/utils/validators/validate.dart';

class BusinessSignUserForm extends StatefulWidget {
  const BusinessSignUserForm({Key? key}) : super(key: key);

  @override
  State<BusinessSignUserForm> createState() => _BusinessSignUserFormState();
}

class _BusinessSignUserFormState extends State<BusinessSignUserForm> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController businessNamecontroller = TextEditingController();
  TextEditingController businessAddresscontroller = TextEditingController();
  TextEditingController businessRegistrationNumbercontroller =
      TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  TextStyle labelStyle = const TextStyle();

  File? _image;

  String labelText = '';

  //UPLOAD IMAGE FUNCTION

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
  //SIGN UP BUSINESS USER FUNCTION

  void _signUpBusinessUser() {
    final SignUpController signUpController = SignUpController();
    signUpController.signUpBusinessUser(
      emailcontroller.text,
      passwordcontroller.text,
      usernamecontroller.text,
      biocontroller.text,
      businessNamecontroller.text,
      businessAddresscontroller.text,
      businessRegistrationNumbercontroller.text,
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
          title: const Text('Business Sign User Form'),
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

                //BUSINESS NAME
                Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: businessNameTextFormField(
                    businessNamecontroller: businessNamecontroller,
                    labelText: labelText,
                    validator: Validators.validateBusinessName,
                  ),
                ),
                //BUSINESS ADDRESS
                Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: businessAddressTextFormField(
                    businessAddresscontroller: businessAddresscontroller,
                    labelText: labelText,
                    validator: Validators.validateBusinessAddress,
                  ),
                ),
                //BUSINESS REGISTRATION NUMBER
                Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: businessRegistrationNumberTextFormField(
                    businessRegistrationNumbercontroller:
                        businessRegistrationNumbercontroller,
                    labelText: labelText,
                    validator: Validators.validateBusinessRegistrationNumber,
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
                  padding: const EdgeInsets.all(21.0),
                  child: SignUpButton(
                    onPressed: _signUpBusinessUser,
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
