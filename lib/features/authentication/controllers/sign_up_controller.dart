import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/authentication/models/create_user_model.dart';
import 'package:jusso_2024_file/repositories/auth_repository.dart';
import 'package:jusso_2024_file/repositories/user_repository.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class SignUpController {
  final FirebaseAuthRepository _authRepository = FirebaseAuthRepository();
  final UserRepository _userRepository = UserRepository();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // SIGN UP SOCIAL USER FUNCTION
  Future<void> signUpSocialUser(String email, String password, String username,
      String bio, File? image, BuildContext context) async {
    try {
      // Sign up the user with email and password
      User? user =
          await _authRepository.signupWithEmailAndPassword(email, password);

      if (user != null) {
        String profileImageURL = await _uploadImageToFirebase(user.uid, image!);
        SocialUserModel socialUser = SocialUserModel(
          uid: user.uid,
          email: email,
          username: username,
          bio: bio,
          password: password,
          profileImage: profileImageURL,
          accountType: AccountType.social,
        );
        await _userRepository.addSocialUser(socialUser);

        // Show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account Created',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: JColors.primaryColor,
          ),
        );

        // Navigate to dashboard
        Navigator.pushNamed(context, '/dashboard');
      }
    } catch (e) {
      print("Error signing up: $e");
    }
  }

  // SIGN UP BUSINESS USER FUNCTION
  Future<void> signUpBusinessUser(
      String email,
      String password,
      String username,
      String bio,
      String businessName,
      String businessAddress,
      String businessRegistrationNumber,
      File? image,
      BuildContext context) async {
    try {
      // Sign up the user with email and password
      User? user =
          await _authRepository.signupWithEmailAndPassword(email, password);

      if (user != null) {
        String profileImageURL = await _uploadImageToFirebase(user.uid, image!);
        BusinessUserModel businessUser = BusinessUserModel(
          uid: user.uid,
          email: email,
          username: username,
          bio: bio,
          password: password,
          businessName: businessName,
          businessAddress: businessAddress,
          businessRegistrationNumber: businessRegistrationNumber,
          profileImage: profileImageURL,
          status: 'pending',
          accountType: AccountType.business,
        );
        await _userRepository.addBusinessUser(businessUser);

        // Show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account is Now Pending',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: JColors.primaryColor,
          ),
        );

        // Navigate to login screen
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      print("Error signing up: $e");
    }
  }

  // Upload image to Firebase Storage
  Future<String> _uploadImageToFirebase(String uid, File image) async {
    try {
      String fileName = 'profile_images/$uid';
      final Reference storageReference = _storage.ref().child(fileName);
      final UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() => null);
      return await storageReference.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }
}
