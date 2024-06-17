import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jusso_o/authentication/reset%20password/reset%20password%20screen/reset_password_screen.dart';
import 'package:jusso_o/authentication/sign%20up/sign%20up%20screen/sign_up_screen.dart';
import 'package:jusso_o/utilities/components/buttons/login%20button/login_button.dart';
import 'package:jusso_o/utilities/components/textfields/email%20textfield/email_textfield.dart';
import 'package:jusso_o/utilities/components/textfields/password%20textfield/password_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Image(image: AssetImage('assets/Logo.png')),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: EmailTextfield(),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: PasswordTextfield(),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Text('Remember me',
                          style: TextStyle(color: Colors.blue)),
                      Checkbox(
                        value: false,
                        onChanged: (value) {
                          // Handle checkbox change
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen()),
                      );
                    },
                    child: const Text('Forgot Password?',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: LoginButton(),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Continue with Google or Apple',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.grey,
                      size: 45,
                    ),
                    onPressed: () {
                      // Handle Google sign-in
                    },
                  ),
                  const SizedBox(width: 21),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.apple,
                      color: Colors.grey,
                      size: 45,
                    ),
                    onPressed: () {
                      // Handle Apple sign-in
                    },
                  )
                ],
              ),
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
