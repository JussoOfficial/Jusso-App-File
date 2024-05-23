// CONTENT MODEL

import 'package:cloud_firestore/cloud_firestore.dart';

class ContentModel {
  final String uid;
  final String creatorName;
  final String mediaUrl;
  final String postId;
  final String contentDescription;
  final int likes;
  final int comments;
  final int shares;

  ContentModel({
    required this.uid,
    required this.creatorName,
    required this.mediaUrl,
    required this.postId,
    required this.contentDescription,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      uid: map['uid'],
      creatorName: map['creatorName'],
      contentDescription: map['contentDescription'],
      mediaUrl: map['mediaUrl'],
      postId: map['postId'],
      likes: map['likes'],
      comments: map['comments'],
      shares: map['shares'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'creatorName': creatorName,
      'mediaUrl': mediaUrl,
      'postId': postId,
      'contentDescription': contentDescription,
      'likes': likes,
      'comments': comments,
      'shares': shares,
    };
  }
}

// COMMENT MODEL
class CommentModel {
  final String uid;
  final String username;
  final String postId;
  final String comment;
  final DateTime timestamp; // Updated type to DateTime

  CommentModel({
    required this.uid,
    required this.username,
    required this.postId,
    required this.comment,
    required this.timestamp,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      uid: map['userId'],
      username: map['username'],
      postId: map['postId'],
      comment: map['comment'],
      timestamp: (map['timestamp'] as Timestamp)
          .toDate(), // Convert Timestamp to DateTime
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'comment': comment,
      'postId': postId,
      'timestamp':
          timestamp, // Assuming timestamp is already in DateTime format
    };
  }
}

//SEARCH MODEL

class SearchModel {
  final String uid;
  final String username;

  SearchModel({
    required this.uid,
    required this.username,
  });

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      uid: map['uid'],
      username: map['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
    };
  }
}
