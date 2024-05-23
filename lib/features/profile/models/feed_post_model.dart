class FeedPostModel {
  // Parameters
  final String userId;
  final String postId;
  final String postUsername;
  final String postDescription;
  final String feedpostMediaUrl; // Updated parameter name
  final String postThumbnailUrl;
  int postLikes;
  int postComments;
  int postShares;

  FeedPostModel({
    required this.userId,
    required this.postId,
    required this.postUsername,
    required this.postDescription,
    required this.feedpostMediaUrl, // Updated parameter name
    required this.postThumbnailUrl,
    required this.postLikes,
    required this.postComments,
    required this.postShares,
  });

  // Convert from JSON
  factory FeedPostModel.fromJson(Map<String, dynamic> json) {
    return FeedPostModel(
      userId: json['userId'],
      postId: json['postId'],
      postUsername: json['postUsername'],
      postDescription: json['postDescription'],
      feedpostMediaUrl: json['feedpostMediaUrl'], // Updated field name
      postThumbnailUrl: json['postThumbnailUrl'],
      postLikes: json['postLikes'],
      postComments: json['postComments'],
      postShares: json['postShares'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'postId': postId,
      'postUsername': postUsername,
      'postDescription': postDescription,
      'feedpostMediaUrl': feedpostMediaUrl, // Updated field name
      'postThumbnailUrl': postThumbnailUrl,
      'postLikes': postLikes,
      'postComments': postComments,
      'postShares': postShares,
    };
  }

  // CopyWith method
  FeedPostModel copyWith({
    String? userId,
    String? postId,
    String? postUsername,
    String? postDescription,
    String? feedpostMediaUrl,
    String? postThumbnailUrl,
    int? postLikes,
    int? postComments,
    int? postShares,
  }) {
    return FeedPostModel(
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      postUsername: postUsername ?? this.postUsername,
      postDescription: postDescription ?? this.postDescription,
      feedpostMediaUrl: feedpostMediaUrl ?? this.feedpostMediaUrl,
      postThumbnailUrl: postThumbnailUrl ?? this.postThumbnailUrl,
      postLikes: postLikes ?? this.postLikes,
      postComments: postComments ?? this.postComments,
      postShares: postShares ?? this.postShares,
    );
  }
}
