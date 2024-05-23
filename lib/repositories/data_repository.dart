import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//DATA REPOSITORY
  //FETCH FOR YOU DATA
  Future<List<DocumentSnapshot>> fetchForYouData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('ForYou').get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching data from ForYou collection: $e");
      throw Exception("Error fetching data from ForYou collection: $e");
    }
  }

  //FETCH FOLLOWING DATA
  Future<List<DocumentSnapshot>> fetchFollowingData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Following').get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching data from Following collection: $e");
      throw Exception("Error fetching data from Following collection: $e");
    }
  }

  //FETCH SEARCH DATA
  Future<List<DocumentSnapshot>> fetchSearchData() async {
    try {
      QuerySnapshot socialUsersSnapshot =
          await _firestore.collection('SocialUsers').get();
      QuerySnapshot businessUsersSnapshot =
          await _firestore.collection('BusinessUsers').get();
      return [...socialUsersSnapshot.docs, ...businessUsersSnapshot.docs];
    } catch (e) {
      print("Error fetching data for search page: $e");
      throw Exception("Error fetching data for search page: $e");
    }
  }

  //FETCH USER CHAT CARD
  Future<List<DocumentSnapshot>> fetchUserChatCardData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('UserChatCard').get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching user chat card data: $e");
      throw Exception("Error fetching user chat card data: $e");
    }
  }

  //FETCH USER CHAT
  Future<List<DocumentSnapshot>> fetchUserChatData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('UserChat').get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching user chat data: $e");
      throw Exception("Error fetching user chat data: $e");
    }
  }

  //FETCH NOTIFICATIONS
  Future<List<DocumentSnapshot>> fetchNotificationsData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Notifications').get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching notifications data: $e");
      throw Exception("Error fetching notifications data: $e");
    }
  }

  //FETCH FEED POST
  Future<List<DocumentSnapshot>> fetchFeedPostData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Feed Post').get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching feed post data: $e");
      throw Exception("Error fetching feed post data: $e");
    }
  }

  //FETCH FEED COMMENT
  Future<List<DocumentSnapshot>> fetchFeedCommentData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Feed Comment').get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching feed comment data: $e");
      throw Exception("Error fetching feed comment data: $e");
    }
  }
}
