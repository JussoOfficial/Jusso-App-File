import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/features/authentication/models/login_model.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SIGN IN WITH EMAIL AND PASSWORD
  Future<void> signInWithEmailAndPassword(
    LoginModel loginModel, {
    required String email,
    required String password,
  }) async {
    try {
      // TRY TO SIGN IN THE USER WITH EMAIL AND PASSWORD
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //REFRACTOR THIS PART OF THE CODE
      //ADD FUNCTION TO FETCH DOCUMENT SNAPSHOT FROM SOCIAL USERS COLLECTION
      //SHOW SNACKBAR SUCCESS MESSAGE AND NAVIGATE TO DASHBOARD PAGE

      // CHECK IF USER DATA EXIST IN BUSINESS COLLECTION
      DocumentSnapshot businessUserSnapshot = await _firestore
          .collection('BusinessUsers')
          .doc(userCredential.user!.uid)
          .get();

      // CHECK IF USER DATA EXIST IN SOCIAL COLLECTION
      DocumentSnapshot socialUserSnapshot = await _firestore
          .collection('SocialUsers')
          .doc(userCredential.user!.uid)
          .get();

      //IF USER DATA EXIST IN BUSINESS COLLECTION
      if (businessUserSnapshot.exists) {
        // GET USER STATUS
        String status = businessUserSnapshot.get('status');
        // CHECK USER STATUS
        if (status == 'pending') {
          // SHOW PENDING MESSAGE
          print('User status is pending');
          displayPendingSnackbar('Your account is pending. Please wait.');
        } else if (status == 'active') {
          // SHOW SUCCESS MESSAGE
          print('User status is active');
          // SUCCESSFUL SIGN IN
          print('User email: ${userCredential.user!.email}');
          print('User uid: ${userCredential.user!.uid}');
          // SUCCESSFUL SIGN IN
          String username = businessUserSnapshot.get('username');
          displaySuccessAndNavigate('HI , $username');
          displayErrorSnackbar('Error signing in User. Please try again.');
        }
      }
      //IF USER DATA EXIST IN SOCIAL COLLECTION
      if (socialUserSnapshot.exists) {
        // SHOW SUCCESS MESSAGE
        print('User email: ${userCredential.user!.email}');
        print('User uid: ${userCredential.user!.uid}');
        // SUCCESSFUL SIGN IN
        String username = socialUserSnapshot.get('username');
        displaySuccessAndNavigate('HI  , $username');
      }
    } catch (e) {
      // SHOW ERROR MESSAGE
      print('Error signing in with email and password: $e');
      displayErrorSnackbar('Error signing in User. Please try again.');
    }
  }
}

void displaySuccessAndNavigate(String message) {
  // SHOW SUCCESS MESSAGE
  Get.snackbar('Welcome back to Jusso', message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: JColors.primaryColor,
      duration: const Duration(seconds: 6),
      colorText: Colors.white);
  // NAVIGATE TO DASHBOARD PAGE
  Get.toNamed('/dashboard');
}

void displayErrorSnackbar(String message) {
  // SHOW ERROR MESSAGE
  Get.snackbar('Error', message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 6),
      colorText: Colors.white);
}

void displayPendingSnackbar(String message) {
  // SHOW ERROR MESSAGE
  Get.snackbar('Pending', message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: JColors.primaryColor,
      duration: const Duration(seconds: 6),
      colorText: Colors.white);
}
