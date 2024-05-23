//EDIT PROFILE MODEL
class EditProfileModel {
  final String profileImage;
  final String username;
  final String bio;
//
  EditProfileModel({
    required this.profileImage,
    required this.username,
    required this.bio,
  });

  factory EditProfileModel.fromMap(Map<String, dynamic> map) {
    return EditProfileModel(
      profileImage: map['profileImage'],
      username: map['username'],
      bio: map['bio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage,
      'username': username,
      'bio': bio,
    };
  }
}
