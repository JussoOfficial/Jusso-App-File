import 'package:flutter/material.dart';
import 'package:jusso_o/utilities/components/buttons/general/back%20button/back_button.dart';

class ResetPasswordLinkSentScreen extends StatelessWidget {
  const ResetPasswordLinkSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Link Sent Successfully.',
        ),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 21,
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
                'We have sent a link to reset your password. Please check your email.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
          ),
          SizedBox(
            height: 72,
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: BackToLoginButton(),
          )
        ],
      ),
    );
  }
}
