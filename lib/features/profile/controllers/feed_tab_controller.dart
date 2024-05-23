import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FeedTabController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    ();
  }

  Future<User?> getCurrentUser() async {
    print('User email: ${_auth.currentUser?.email}');
    print('User uid: ${_auth.currentUser?.uid}');

    return _auth.currentUser;
  }

  // Fetch  list of Thumbnail urls from firestore
  Future<List<String>> fetchThumbnailUrls() async {
    List<String> thumbnailUrls = [];

    QuerySnapshot querySnapshot = await _firestore
        .collection('Content')
        .doc('Feed')
        .collection('Feed Post')
        .where('userId', isEqualTo: _auth.currentUser?.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String? thumbnailUrl = doc['postThumbnailUrl'];
        if (thumbnailUrl != null) {
          thumbnailUrls.add(thumbnailUrl);
        } else {
          throw Exception(
              'postThumbnailUrl field is null for document: ${doc.id}');
        }
      }
    }

    return thumbnailUrls;
  }

  Future<List<Map<String, dynamic>>> fetchFeedPostsForCurrentUser() async {
    List<Map<String, dynamic>> feedPosts = [];

    QuerySnapshot querySnapshot = await _firestore
        .collection('Content')
        .doc('Feed')
        .collection('Feed Post')
        .where('userId', isEqualTo: _auth.currentUser?.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> post = {
          'postId': doc['postId'],
          'postUsername': doc['postUsername'],
          'postDescription': doc['postDescription'],
          'feedpostMediaUrl': doc['feedpostMediaUrl'],
          'postLikes': doc['postLikes'],
          'postComments': doc['postComments'],
          'postShares': doc['postShares'],
        };

        feedPosts.add(post);
      }
    } else {
      throw Exception('No posts found for the current user');
    }

    return feedPosts;
  }

  // CREATE FUNCTION TO RETIEVE COMMENTS FORM FOR YOU AND FOLLOWING COMMENTS AND FEED COMMENT COLLECTION

  //  QUERY LIST OF DOCUMENT SNAPSHOTS FOR THE TWO COLLECTIONS
  // IF COLLECTIONS EMPTY THROW EXCEPTION
  Future<List<Map<String, dynamic>>> fetchCommentsForPost(String postId) async {
    List<Map<String, dynamic>> comments = [];

    // Fetch comments from 'Comments' collection based on the postId
    QuerySnapshot querySnapshot = await _firestore
        .collection('Content')
        .doc('Feed ')
        .collection('Feed Comments')
        .where('postId', isEqualTo: postId)
        .get();

    // Process each document to extract comment details
    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> comment = {
          'username': doc['username'],
          'commentText': doc['commentText'],
          'postId': doc['postId'],
        };
        comments.add(comment);
      }
    }

    return comments;
  }
}
