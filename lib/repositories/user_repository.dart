import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jusso_2024_file/features/authentication/models/create_user_model.dart';

class UserRepository extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _localStorage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

// ADD USER FUNCTION

// ADD SOCIAL USER
  Future<void> addSocialUser(SocialUserModel user) async {
    try {
      await _firestore
          .collection('SocialUsers')
          .doc(user.uid)
          .set(user.toJson());
      _localStorage.write('user', user.toJson());
    } catch (e) {
      print("Error adding user: $e");
    }
  }

// ADD BUSINESS USER
  Future<void> addBusinessUser(BusinessUserModel user) async {
    try {
      await _firestore
          .collection('BusinessUsers')
          .doc(user.uid)
          .set(user.toJson());
      _localStorage.write('user', user.toJson());
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  // GET USER DOCUMENT FUNCTION
  Future<DocumentSnapshot> getUser(String userId, String collection) async {
    try {
      String userCollection = '';
      if (collection == 'SocialUsers') {
        userCollection = 'SocialUsers';
      } else if (collection == 'BusinessUsers') {
        userCollection = 'BusinessUsers';
      } else {
        throw Exception('Invalid collection name');
      }
      return await _firestore.collection(userCollection).doc(userId).get();
    } catch (e) {
      print("Error getting user document: $e");
      throw Exception("Error getting user document: $e");
    }
  }

  // UPDATE USER DOCUMENT FUNCTION
  Future<void> updateUser(
      String userId, String collection, Map<String, dynamic> data) async {
    try {
      String userCollection = '';
      if (collection == 'SocialUsers') {
        userCollection = 'SocialUsers';
      } else if (collection == 'BusinessUsers') {
        userCollection = 'BusinessUsers';
      } else {
        throw Exception('Invalid collection name');
      }
      await _firestore.collection(userCollection).doc(userId).update(data);
    } catch (e) {
      print("Error updating user document: $e");
      throw Exception("Error updating user document: $e");
    }
  }

  // DELETE USER DOCUMENT FUNCTION
  Future<void> deleteUser(String userId, String collection) async {
    try {
      String userCollection = '';
      if (collection == 'SocialUsers') {
        userCollection = 'SocialUsers';
      } else if (collection == 'BusinessUsers') {
        userCollection = 'BusinessUsers';
      } else {
        throw Exception('Invalid collection name');
      }
      await _firestore.collection(userCollection).doc(userId).delete();
    } catch (e) {
      print("Error deleting user document: $e");
      throw Exception("Error deleting user document: $e");
    }

    // Update User Status in Business Users Collection
    Future<void> updateUserStatus(
        String userId, String status, String duration) async {
      try {
        // Update status and duration in Business Users collection
        await _firestore.collection('BusinessUsers').doc(userId).update({
          'status': status,
          'duration': duration,
        });
      } catch (e) {
        print('Error updating user status: $e');
      }
    }
  }

  // Fetch Business Users Collection List from Firestore
  Future<List<Map<String, dynamic>>?> fetchBusinessUsers() async {
    try {
      // Authenticate using jussoadmin@gmail.com
      await _auth.signInWithEmailAndPassword(
        email: 'jusso2023@gmail.com',
        password: 'JussoHere',
      );

      // Retrieve the business users collection
      QuerySnapshot querySnapshot =
          await _firestore.collection('BusinessUsers').get();

      // Extract required data parameters
      List<Map<String, dynamic>> businessUsersList = [];
      querySnapshot.docs.forEach((DocumentSnapshot doc) {
        businessUsersList.add({
          'status': doc['status'],
          'accountType': doc['accountType'],
          'username': doc['username'],
          'duration': doc['duration'],
        });
      });

      return businessUsersList;
    } catch (e) {
      print('Error fetching business users: $e');
      return null;
    }
  }
}
