import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PendingController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
          'username': doc['businessName'],
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
