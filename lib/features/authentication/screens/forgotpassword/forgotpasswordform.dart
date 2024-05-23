import 'package:flutter/material.dart';
import 'package:jusso_2024_file/common/common_widgets.dart';
import 'package:jusso_2024_file/features/authentication/controllers/forgot_password_controller.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:jusso_2024_file/utils/validators/validate.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final ForgotPasswordController forgotPasswordController =
        ForgotPasswordController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reset Password by Email',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: emailTextFormField(
                emailcontroller: emailController,
                labelText: 'Email',
                validator: Validators.validateEmail,
                hintText: 'Enter your email',
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              width: 200, // Adjust the width according to your preference
              height: 50, // Adjust the height according to your preference
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: JColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  forgotPasswordController
                      .sendForgotPasswordLink(emailController.text);
                  // Optionally, you can navigate to another page after sending the reset password link
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
