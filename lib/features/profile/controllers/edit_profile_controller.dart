import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/features/profile/models/edit_profile_model.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> updateUserProfile(
      EditProfileModel profile, File? imageFile) async {
    try {
      // Get the current user
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String userId = currentUser.uid;

        // Upload image file to Firebase Storage
        String imageUrl = '';
        if (imageFile != null) {
          final storageRef =
              _storage.ref().child('profile_images').child(userId);
          final uploadTask = storageRef.putFile(imageFile);
          await uploadTask.whenComplete(() async {
            imageUrl = await storageRef.getDownloadURL();
          });
        }

        // Check if the user document exists in the Social Users collection
        DocumentSnapshot<Map<String, dynamic>> socialUserSnapshot =
            await _firestore.collection('SocialUsers').doc(userId).get();

        // Check if the user document exists in the Business Users collection
        DocumentSnapshot<Map<String, dynamic>> businessUserSnapshot =
            await _firestore.collection('BusinessUsers').doc(userId).get();

        // Check if the user document exists in Social Users collection and update profile
        if (socialUserSnapshot.exists) {
          await _firestore.collection('SocialUsers').doc(userId).update({
            'username': profile.username,
            'bio': profile.bio,
            'profileImage': imageUrl, // Update profile image URL
          });
          print('Social user profile updated with:');
          print('Username: ${profile.username}');
          print('Bio: ${profile.bio}');
          print('Profile Image URL: $imageUrl');
          Get.snackbar(
            'Success',
            'Profile updated successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: JColors.primaryColor,
            colorText: Colors.white,
          );
        }
        // If not found in Social Users collection, check and update in Business Users collection
        else if (businessUserSnapshot.exists) {
          await _firestore.collection('BusinessUsers').doc(userId).update({
            'username': profile.username,
            'bio': profile.bio,
            'profileImage': imageUrl, // Update profile image URL
          });
          print('Business user profile updated with:');
          print('Username: ${profile.username}');
          print('Bio: ${profile.bio}');
          print('Profile Image URL: $imageUrl');
          Get.snackbar(
            'Success',
            'Profile updated successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          print(
              'User document not found in SocialUsers or BusinessUsers collection.');
          // Handle the case where user document is not found in both collections
        }
      } else {
        print('Current user is null');
        // Handle the case where current user is null
      }
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }
}
