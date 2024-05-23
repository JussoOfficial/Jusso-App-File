//PROFILE MODEL
class ProfileModel {
  final String uid;
  final String username;
  final String profileImage;
  final String bio;
  final int followers;
  final int followings;

  ProfileModel({
    required this.uid,
    required this.username,
    required this.profileImage,
    required this.bio,
    required this.followers,
    required this.followings,
  });

  // Factory constructor to create ProfileModel from map
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      profileImage: map['profileImage'] ?? '',
      bio: map['bio'] ?? '',
      followers: map['followers'] ?? 0,
      followings: map['followings'] ?? 0,
    );
  }

  // Method to convert ProfileModel to map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'profileImage': profileImage,
      'bio': bio,
      'followers': followers,
      'followings': followings,
    };
  }

  // Factory constructor to create an empty ProfileModel
  factory ProfileModel.empty() {
    return ProfileModel(
      uid: '',
      username: '',
      profileImage: '',
      bio: '',
      followers: 0,
      followings: 0,
    );
  }
}

/////////////////////////////////////////////////////////////////////




//