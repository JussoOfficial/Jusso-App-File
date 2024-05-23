//LOGIN MODEL

class LoginModel {
  final String uid;
  final String email;
  final String password;
  final String status;

  LoginModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.status,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'status': status,
    };
  }
}
