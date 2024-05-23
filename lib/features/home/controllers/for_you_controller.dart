import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ForYouController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get the current user
  User? get currentUser => _auth.currentUser;

  // Fetch content for the current user
  Future<List<QueryDocumentSnapshot<Map<String, Object?>>>>
      fetchContentForCurrentUser() async {
    QuerySnapshot<Map<String, Object?>> querySnapshot = await _firestore
        .collection('Content')
        .doc('ForYou & Following')
        .collection('For You')
        .get();

    // Debug: Print the number of documents fetched
    print('User email: ${_auth.currentUser?.email}');

    return querySnapshot.docs;
  }

  // Function to determine if the media is an image or video using metadata
  Future<String> getMediaType(String mediaUrl) async {
    try {
      var ref = _storage.refFromURL(mediaUrl);
      var metadata = await ref.getMetadata();
      var contentType = metadata.contentType;

      // Determine media type based on content type
      if (contentType != null && contentType.startsWith('video')) {
        return 'video';
      } else if (contentType != null && contentType.startsWith('image')) {
        return 'image';
      } else {
        return 'unknown';
      }
    } catch (e) {
      print('Error fetching media metadata: $e');
      return 'unknown';
    }
  }

// Function to fetch comments for a specific post
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchComments(
      String postId) async {
    print('Fetching comments for postId: $postId');

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('Content')
        .doc('ForYou & Following')
        .collection('For You and Following Comments')
        .where('postId', isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .get();

    if (snapshot.docs.isEmpty) {
      print('No comments found for post with postId: $postId');
      return [];
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>> commentDocs =
        snapshot.docs;

    // Debug: Print the number of comments fetched
    print('Number of comments fetched for post $postId: ${commentDocs.length}');

    // Print the data of each document
    for (var doc in commentDocs) {
      print('Document data: ${doc.data()}');
    }

    return commentDocs;
  }

  //function for current user to like the content post
  Future<void> likePost(String postId) async {
    // doc reference for the  for you  post
    QuerySnapshot<Map<String, dynamic>> forYouDoc = await _firestore
        .collection('Content')
        .doc('ForYou & Following')
        .collection('For You')
        .where('postId', isEqualTo: postId)
        .get();
    // update the like count in documents stored in the  for you collection
    return _firestore.runTransaction((transaction) async {
      for (QueryDocumentSnapshot doc in forYouDoc.docs) {
        DocumentReference docRef = doc.reference;
        int newLikeCount = (doc['likes'] ?? 0) + 1;

        transaction.update(docRef, {'likes': newLikeCount});
      }
      // doc reference for the  feedpost  post
      QuerySnapshot<Map<String, dynamic>> feedpostDoc = await _firestore
          .collection('Content')
          .doc('Feed')
          .collection(' Feed Posts')
          .where('postId', isEqualTo: postId)
          .get();

      // update the like count in documents stored in the feedpost collection
      return _firestore.runTransaction((transaction) async {
        for (QueryDocumentSnapshot doc in feedpostDoc.docs) {
          DocumentReference docRef = doc.reference;
          int newLikeCount = (doc['postlikes'] ?? 0) + 1;
          transaction.update(docRef, {'postlikes': newLikeCount});
        }
      }).then((_) {
        print('Like count updated for postId: $postId');
      }).catchError((error) {
        print('Error updating like count: $error');
      });
    });
  }

  //function for current user to share the content post
  Future<void> sharePost(String postId) async {
    // share post to whatsapp and instagram using url launcher
  }

  //function for current user to follow content user
  Future<void> followUser(String userId) async {
    // update follower and following count of both user documents
    // send notification that follower notification to user followed
  }
}
