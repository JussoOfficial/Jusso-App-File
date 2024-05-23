import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;

  String? _username;
  String? get username => _username;

  String? _accountType;
  String? get accountType => _accountType;

  String? _status;
  String? get status => _status;

  // Call getCurrentUser() when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  // Fetch current user data from Firestore collection
  Future<void> getCurrentUser() async {
    currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Check if the user UID exists in "social_users" collection
      final socialUserDoc = await FirebaseFirestore.instance
          .collection('SocialUsers')
          .doc(currentUser!.uid)
          .get();
      if (socialUserDoc.exists) {
        // User found in "social_users" collection, retrieve user data
        final userData = socialUserDoc.data() as Map<String, dynamic>;
        print('social user data: $userData');
        _username = userData['username'];
        _accountType = userData['accountType'];
        _status = userData['status'];
        update(); // Update the UI after fetching data
      } else {
        // User not found in "social_users" collection, check "business_users" collection
        final businessUserDoc = await FirebaseFirestore.instance
            .collection('BusinessUsers')
            .doc(currentUser!.uid)
            .get();
        if (businessUserDoc.exists) {
          // User found in "business_users" collection, retrieve user data
          final userData = businessUserDoc.data() as Map<String, dynamic>;
          print('business user data: $userData');
          _username = userData['businessName'];
          _accountType = userData['accountType'];
          _status = userData['status'];
          update(); // Update the UI after fetching data
        } else {
          // User document not found
          _username = null;
          _accountType = null;
          _status = null;
          update(); // Update the UI after fetching data
        }
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('Signed out successfully');
      print('User email: ${_auth.currentUser?.email}');
      print('User uid: ${_auth.currentUser?.uid}');
      // Add any additional cleanup or navigation logic after signing out
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
