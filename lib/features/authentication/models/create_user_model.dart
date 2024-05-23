enum AccountType {
  social,
  business,
}

class SocialUserModel {
  final String uid;
  final String email;
  final String username;
  final String bio;
  final String password;
  final String profileImage;
  final AccountType accountType;

  SocialUserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.password,
    required this.profileImage,
    required this.accountType,
  });

  factory SocialUserModel.fromJson(Map<String, dynamic> json) {
    return SocialUserModel(
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      bio: json['bio'],
      password: json['password'],
      profileImage: json['profileImage'],
      accountType: AccountType.values.firstWhere(
        (e) => e.toString() == 'AccountType.' + json['accountType'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'bio': bio,
      'password': password,
      'profileImage': profileImage,
      'accountType': accountType.toString().split('.')[1],
    };
  }
}

class BusinessUserModel {
  final String uid;
  final String email;
  final String username;
  final String bio;
  final String password;
  final String businessName;
  final String businessAddress;
  final String businessRegistrationNumber;
  final String profileImage;
  final String status;
  final AccountType accountType;

  BusinessUserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.password,
    required this.businessName,
    required this.businessAddress,
    required this.businessRegistrationNumber,
    required this.profileImage,
    required this.status,
    required this.accountType,
  });

  factory BusinessUserModel.fromJson(Map<String, dynamic> json) {
    return BusinessUserModel(
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      bio: json['bio'],
      password: json['password'],
      businessName: json['businessName'],
      businessAddress: json['businessAddress'],
      businessRegistrationNumber: json['businessRegistrationNumber'],
      profileImage: json['profileImage'],
      status: json['status'],
      accountType: AccountType.values.firstWhere(
        (e) => e.toString() == 'AccountType.' + json['accountType'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'bio': bio,
      'password': password,
      'businessName': businessName,
      'businessAddress': businessAddress,
      'businessRegistrationNumber': businessRegistrationNumber,
      'profileImage': profileImage,
      'status': status,
      'accountType': accountType.toString().split('.')[1],
    };
  }
}
