import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendForgotPasswordLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      Get.snackbar('Success', 'Password reset link sent to $email',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // An error occurred while sending the password reset email
      Get.snackbar('Error', 'Failed to send password reset link: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
