import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/features/profile/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<User?> currentUser = Rx<User?>(null);
  Rx<Map<String, dynamic>?> userProfile = Rx<Map<String, dynamic>?>(null);

  // Fetch current user from Firebase Auth
  Future<void> getCurrentUser() async {
    currentUser.value = _auth.currentUser;
    if (currentUser.value != null) {
      await getUserProfile(currentUser.value!.uid);
      print('User email: ${currentUser.value!.email}');
      print('User uid: ${currentUser.value!.uid}');
    }
  }

  // Fetch user profile from Firestore based on collection where uid is stored
  Future<void> getUserProfile(String userId) async {
    try {
      // Check if the user is a SocialUser or BusinessUser
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('SocialUsers').doc(userId).get();
      if (snapshot.exists) {
        userProfile.value = snapshot.data();
        printUserProfile();
      } else {
        snapshot =
            await _firestore.collection('BusinessUsers').doc(userId).get();
        userProfile.value = snapshot.data();
        printUserProfile();
      }
    } catch (e) {
      print("Error getting user profile: $e");
    }
  }

  void printUserProfile() {
    print('User uid: ${userProfile.value!['uid']} ');
    print('User email: ${userProfile.value!['email']} ');
    print('User username: ${userProfile.value!['username']} ');
    print('User bio: ${userProfile.value!['bio']} ');
    print('User followers: ${userProfile.value!['followers']} ');
    print('User followings: ${userProfile.value!['followings']} ');
  }

  // Save user profile to local storage
  Future<void> saveUserProfile(ProfileModel profile) async {
    try {
      // Save the user profile data to local storage
      await _saveProfileToLocalStorage(profile);
    } catch (e) {
      print("Error saving user profile: $e");
    }
  }

  Future<void> _saveProfileToLocalStorage(ProfileModel profile) async {
    // Use a local storage solution like shared_preferences or hive to save the profile data
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileName', profile.username);
    await prefs.setString('profileBio', profile.bio);
    await prefs.setString('profileImage', profile.profileImage);
    await prefs.setInt('followers', profile.followers);
    await prefs.setInt('followings', profile.followings);
    // Save other profile fields as needed
  }

  @override
  void onReady() {
    super.onReady();
    // Delay the execution of getCurrentUser by a short duration
    Future.delayed(Duration(milliseconds: 360), getCurrentUser);
  }
}
