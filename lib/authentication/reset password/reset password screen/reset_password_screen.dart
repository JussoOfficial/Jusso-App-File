import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jusso_o/utilities/components/buttons/reset%20password%20button/reset_password_button.dart';
import 'package:jusso_o/utilities/components/textfields/email%20textfield/email_textfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepOrange,
            title: const Text(
              'Reset your Jusso Password.',
            ),
            titleTextStyle: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 21,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                    Text('Enter your email to send a link to reset Password.',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
              ),
              const SizedBox(
                height: 72,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: EmailTextfield(),
              ),
              const SizedBox(
                height: 120,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: ResetPasswordButton(),
              )
            ],
          )),
    );
  }
}
