import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/common/common_widgets.dart';
import 'package:jusso_2024_file/features/admin/screens/admin.dart';
import 'package:jusso_2024_file/features/authentication/controllers/login_controller.dart';
import 'package:jusso_2024_file/features/authentication/models/login_model.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:jusso_2024_file/utils/constants/image_strings.dart';
import 'package:jusso_2024_file/utils/validators/validate.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 241, 241),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 150,
                child: Image.asset(JImages.appLogo),
              ),
              const SizedBox(height: 12),
              // ADMIN ICON - Popup Button
              GestureDetector(
                onTap: () {
                  _showAdminPopup(context);
                },
                child: Icon(Icons.admin_panel_settings,
                    color: const Color.fromARGB(255, 223, 215, 213)),
              ),
              const SizedBox(height: 12),
              // EMAIL TEXTFIELD WIDGET
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: emailTextFormField(
                  emailcontroller: emailController,
                  labelText: 'Email',
                  labelStyle: const TextStyle(),
                  hintText: 'Enter your email',
                  validator: Validators.validateEmail,
                ),
              ),
              const SizedBox(height: 20),
              // PASSWORD TEXTFIELD WIDGET
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: passwordTextFormField(
                  passwordcontroller: passwordController,
                  labelText: 'Password',
                  labelStyle: const TextStyle(),
                  validator: Validators.validatePassword,
                ),
              ),
              const SizedBox(height: 20),
              // FORGOT PASSWORD
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/forgotpassword'),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: JColors.primaryColor),
                ),
              ),
              const SizedBox(height: 21),
              // LOGIN BUTTON
              InkWell(
                child: LogInButton(
                  OnTap: () {
                    // Call your login controller here
                    _loginController.signInWithEmailAndPassword(
                      LoginModel(
                        email: emailController.text,
                        password: passwordController.text,
                        uid: '',
                        status: '',
                      ),
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              //Divider
              const Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              const SizedBox(height: 24),
              // SIGN UP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: JColors.textColorQuaternary, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAdminPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Admin Login'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              emailTextFormField(
                emailcontroller: emailController,
                labelText: 'Email',
                labelStyle: const TextStyle(),
                hintText: 'Enter your email',
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 12),
              // Password text field
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Validate password here
                  if (value != '2002') {
                    return 'Incorrect password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (Validators.validateEmail(emailController.text) == null &&
                      passwordController.text == '2002') {
                    // Navigate to admin dashboard only if email and password are correct
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminDashboard()),
                    );
                  } else {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Invalid email or password'),
                    ));
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        );
      },
    );
  }
}
