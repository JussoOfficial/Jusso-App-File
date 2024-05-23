import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/features/home/models/home_model.dart';
import 'package:jusso_2024_file/features/profile/models/feed_post_model.dart';

class UploadController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Random _random = Random();

  late final File file;
  late final Uint8List? thumbnail;
  late final String description;

  UploadController({
    required this.file,
    this.thumbnail,
    required this.description,
  });

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> uploadFile({
    required File file,
    Uint8List? thumbnail,
    required String description,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception("User not found");
      }

      DocumentSnapshot userDoc;
      DocumentSnapshot socialUserDoc =
          await _firestore.collection('SocialUsers').doc(user.uid).get();
      DocumentSnapshot businessUserDoc =
          await _firestore.collection('BusinessUsers').doc(user.uid).get();

      if (socialUserDoc.exists) {
        userDoc = socialUserDoc;
      } else if (businessUserDoc.exists) {
        userDoc = businessUserDoc;
      } else {
        throw Exception(
            "User document not found in SocialUsers or BusinessUsers collection");
      }

      String accountType = userDoc['accountType'];

      if (accountType == 'social') {
        await uploadContentForSocialUser(userDoc, description);
      } else if (accountType == 'business') {
        await uploadContentForBusinessUser(userDoc, description);
      } else {
        throw Exception("Invalid account type");
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  Future<void> uploadContentForSocialUser(
    DocumentSnapshot userDoc,
    String description,
  ) async {
    try {
      String userId = userDoc.id;
      String postId = '${userId}_${DateTime.now().millisecondsSinceEpoch}';
      String fileType = getFileType(file);
      String mediaUrl = await uploadMediaToStorage(file, fileType);
      String thumbnailUrl =
          thumbnail != null ? await uploadThumbnailToStorage(thumbnail!) : '';

      FeedPostModel feedPost = FeedPostModel(
        userId: userId,
        postId: postId,
        postUsername: userDoc['username'],
        postDescription: description,
        feedpostMediaUrl: mediaUrl,
        postThumbnailUrl: thumbnailUrl,
        postLikes: 0,
        postComments: 0,
        postShares: 0,
      );

      await _firestore
          .collection('Content')
          .doc('Feed')
          .collection('Feed Post')
          .add(feedPost.toJson());

      showSnackbar(Get.context!, 'Content uploaded successfully!');
    } catch (e) {
      print("Error uploading content for SocialUser: $e");
    }
  }

  Future<void> uploadContentForBusinessUser(
    DocumentSnapshot userDoc,
    String description,
  ) async {
    try {
      String userId = userDoc.id;
      String postId = '${userId}_${DateTime.now().millisecondsSinceEpoch}';
      String fileType = getFileType(file);
      String mediaUrl = await uploadMediaToStorage(file, fileType);
      String thumbnailUrl =
          thumbnail != null ? await uploadThumbnailToStorage(thumbnail!) : '';

      FeedPostModel feedPost = FeedPostModel(
        userId: userId,
        postId: postId,
        postUsername: userDoc['username'],
        postDescription: description,
        feedpostMediaUrl: mediaUrl,
        postThumbnailUrl: thumbnailUrl,
        postLikes: 0,
        postComments: 0,
        postShares: 0,
      );

      // Upload to 'Feed' collection
      await _firestore
          .collection('Content')
          .doc('Feed')
          .collection('Feed Post')
          .add(feedPost.toJson());

      ContentModel content = ContentModel(
        uid: userId,
        postId: postId,
        creatorName: userDoc['businessName'],
        contentDescription: description,
        mediaUrl: mediaUrl,
        likes: 0,
        comments: 0,
        shares: 0,
      );

      // Upload to 'For You' collection with the same postId
      await _firestore
          .collection('Content')
          .doc('ForYou & Following')
          .collection('For You')
          .add(content.toMap());

      showSnackbar(Get.context!, 'Content uploaded successfully!');
    } catch (e) {
      print("Error uploading content for BusinessUser: $e");
    }
  }

  String generatePostId() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(
        10, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  String getFileType(File file) {
    String extension = file.path.split('.').last.toLowerCase();
    if (extension == 'mp4' || extension == 'mov' || extension == 'avi') {
      return 'video';
    } else {
      return 'image';
    }
  }

  Future<String> uploadMediaToStorage(
    File file,
    String fileType,
  ) async {
    try {
      Reference ref = _storage.ref().child('media').child(generateFileName());

      // Determine the MIME type of the file based on the fileType parameter
      String mimeType;
      if (fileType == 'video') {
        mimeType = 'video/mp4'; // Assuming all videos are MP4
      } else if (fileType == 'image') {
        mimeType = 'image/jpeg'; // Assuming all images are JPEG
      } else {
        throw Exception('Invalid file type');
      }

      // Upload the file with specified MIME type and metadata
      final metadata = SettableMetadata(
        contentType: mimeType,
        customMetadata: {
          'fileType': fileType,
        },
      );

      UploadTask uploadTask = ref.putFile(
        file,
        metadata,
      );

      TaskSnapshot storageSnapshot = await uploadTask;
      String url = await storageSnapshot.ref.getDownloadURL();
      print('Uploading file: ${file.path}, Type: $fileType');
      return url;
    } catch (e) {
      print("Error uploading media to storage: $e");
      return '';
    }
  }

  Future<String> uploadThumbnailToStorage(Uint8List? thumbnail) async {
    if (thumbnail == null || thumbnail.isEmpty) {
      print('Empty or null thumbnail provided. Skipping upload.');
      return '';
    }

    try {
      Reference ref =
          _storage.ref().child('thumbnails').child(generateFileName());
      UploadTask uploadTask = ref.putData(thumbnail);
      TaskSnapshot storageSnapshot = await uploadTask;
      String url = await storageSnapshot.ref.getDownloadURL();
      print('Uploading thumbnail: Type: thumbnail');
      return url;
    } catch (e) {
      print("Error uploading thumbnail to storage: $e");
      return '';
    }
  }

  String generateFileName() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(
        10, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
