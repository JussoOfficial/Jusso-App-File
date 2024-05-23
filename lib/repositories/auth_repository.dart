import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // CURRENT USER FUNCTION
  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print("Error getting current user: $e");
      return null;
    }
  }

  // SIGN UP USER FUNCTION
  Future<User?> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }

  // SIGN IN USER FUNCTION
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }

  // SIGN OUT USER FUNCTION
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  // SEND RESET PASSWORD LINK FUNCTION
  Future<void> sendResetPasswordLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Reset password link sent to $email");
    } catch (e) {
      print("Error sending reset password link: $e");
    }
  }
}
