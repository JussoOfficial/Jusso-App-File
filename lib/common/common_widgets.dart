import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/authentication/screens/login/login.dart';
import 'package:jusso_2024_file/features/authentication/screens/signup/business_sign_up_form.dart';
import 'package:jusso_2024_file/features/authentication/screens/signup/social_signup_form.dart';
import 'package:jusso_2024_file/features/profile/screens/profile/editprofile_page.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:jusso_2024_file/utils/validators/validate.dart';

//TEXT FIELDS AND BUTTONS

//BUTTONS

//LOGOUT BUTTON
class LogOutButton extends StatefulWidget {
  const LogOutButton({super.key, required Function() onPressed});

  @override
  State<LogOutButton> createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Container(
          height: 54,
          width: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: JColors.primaryColor,
          ),
          child: const Center(
            child: Text(
              'Log Out',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          )),
    );
  }
}

//EDIT PROFILE BUTTON
class EditProfileButton extends StatefulWidget {
  const EditProfileButton({super.key});

  @override
  State<EditProfileButton> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditProfilePage(),
          ),
        );
      },
      child: InkWell(
        child: Container(
          height: 54,
          width: 108,
          decoration: BoxDecoration(
            color: JColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
              child: Text(
            'Edit Profile',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          )),
        ),
      ),
    );
  }
}

//SOCIAL BUTTON
class SocialButton extends StatefulWidget {
  const SocialButton({super.key});

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //NAVIGATE TO SOCIAL FORM
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SocialUserForm(),
          ),
        );
      },
      child: Container(
        height: 60,
        width: 210,
        decoration: BoxDecoration(
          color: JColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: Text('Social Button')),
      ),
    );
  }
}

//BUSINESS BUTTON
class BusinessButton extends StatefulWidget {
  const BusinessButton({super.key});

  @override
  State<BusinessButton> createState() => _BusinessButtonState();
}

class _BusinessButtonState extends State<BusinessButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //NAVIGATE TO BUSINESS FORM
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessSignUserForm(key: UniqueKey()),
            ));
      },
      child: Container(
        height: 60,
        width: 210,
        decoration: BoxDecoration(
          color: JColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: Text('Business Button')),
      ),
    );
  }
}

//LOGIN BUTTON
class LogInButton extends StatelessWidget {
  final Function()? OnTap;
  const LogInButton({super.key, required this.OnTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: OnTap,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(horizontal: 21),
        decoration: BoxDecoration(
          color: JColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(
                color: JColors.accentColor,
                fontSize: 21,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

//BUSINESS SIGN UP BUTTON

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: JColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Sign Up'),
      ),
    );
  }
}

//SOCIAL SIGN UP BUTTON

//TEXT FORM FIELDS

//EMAIL TEXTFORMFIELD WIDGET

TextFormField emailTextFormField({
  required TextEditingController emailcontroller,
  required String labelText,
  required String? Function(String?)? validator,
  required String? hintText,
  required TextStyle labelStyle,
}) {
  return TextFormField(
    controller: emailcontroller,
    decoration: const InputDecoration(
        labelText: ' Email',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: 'Enter your email',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.accentColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.primaryColor)),
        fillColor: JColors.accentColor,
        filled: true),
    validator: Validators.validateEmail,
  );
}

//PASSWORD TEXTFORMFIELD WIDGET
TextFormField passwordTextFormField({
  required TextEditingController passwordcontroller,
  required String labelText,
  required String? Function(String?)? validator,
  required TextStyle labelStyle,
}) {
  return TextFormField(
      controller: passwordcontroller,
      decoration: const InputDecoration(
          labelText: ' Password',
          labelStyle: TextStyle(color: Colors.grey),
          hintText: 'Enter your password',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: JColors.accentColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: JColors.primaryColor)),
          fillColor: JColors.accentColor,
          filled: true),
      obscureText: true,
      validator: Validators.validatePassword);
}

//USERNAME TEXTFORMFIELD WIDGET
TextFormField usernameTextFormField({
  required TextEditingController usernamecontroller,
  required String labelText,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: usernamecontroller,
    decoration: const InputDecoration(
        labelText: ' Username',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: 'Enter your username',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.accentColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.primaryColor)),
        fillColor: JColors.accentColor,
        filled: true),
    validator: Validators.validateUsername,
  );
}

//BIO TEXTFORMFIELD WIDGET
TextFormField bioTextFormField({
  required TextEditingController biocontroller,
  required String labelText,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: biocontroller,
    decoration: const InputDecoration(
        labelText: ' Bio',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: 'Enter your bio',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.accentColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.primaryColor)),
        fillColor: JColors.accentColor,
        filled: true),
    validator: Validators.validateBio,
  );
}

//BUSINESS NAME TEXTFORMFIELD WIDGET
TextFormField businessNameTextFormField({
  required TextEditingController businessNamecontroller,
  required String labelText,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: businessNamecontroller,
    decoration: const InputDecoration(
        labelText: ' Business Name',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: 'Enter your business name',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.accentColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.primaryColor)),
        fillColor: JColors.accentColor,
        filled: true),
    validator: Validators.validateBusinessName,
  );
}

//BUSINESS ADDRESS TEXTFORMFIELD WIDGET

TextFormField businessAddressTextFormField({
  required TextEditingController businessAddresscontroller,
  required String labelText,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: businessAddresscontroller,
    decoration: const InputDecoration(
        labelText: ' Business Address',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: 'Enter your business address',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.accentColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.primaryColor)),
        fillColor: JColors.accentColor,
        filled: true),
    validator: Validators.validateBusinessAddress,
  );
}

//BUSINESS REGISTRATION NUMBER TEXTFORMFIELD WIDGET
TextFormField businessRegistrationNumberTextFormField({
  required TextEditingController businessRegistrationNumbercontroller,
  required String labelText,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: businessRegistrationNumbercontroller,
    decoration: const InputDecoration(
        labelText: ' Business Registration Number',
        labelStyle: TextStyle(color: Colors.grey),
        hintText: 'Enter your business registration number',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.accentColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: JColors.primaryColor)),
        fillColor: JColors.accentColor,
        filled: true),
    validator: Validators.validateBusinessRegistrationNumber,
  );
}

//-------------------------------------------------------------------
///FOLLOW AND FOLLOWING WIDGETS

//----------------------------------------------------------------------------------

//FILTER WIDGETS
