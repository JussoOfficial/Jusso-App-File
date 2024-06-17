import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jusso_o/utilities/components/buttons/social%20account%20form%20button/social_account_form_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Sign Up',
          )),
      body: Center(
        // Center the Column in the middle of the screen
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Constrain the Column's size to the minimum required
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Choose and create your Jusso Account.',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 21,
            ),
            SocialAccountFormButton()
          ],
        ),
      ),
    );
  }
}
