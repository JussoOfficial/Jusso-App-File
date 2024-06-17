import 'package:flutter/material.dart';
import 'package:jusso_o/utilities/components/buttons/general/sign%20up%20button/sign_up_button.dart';
import 'package:jusso_o/utilities/components/textfields/bio%20textfield/bio_textfield.dart';
import 'package:jusso_o/utilities/components/textfields/email%20textfield/email_textfield.dart';
import 'package:jusso_o/utilities/components/textfields/password%20textfield/password_textfield.dart';
import 'package:jusso_o/utilities/components/textfields/username%20textfield/username_textfield.dart';

class SocialAccountFormButton extends StatefulWidget {
  const SocialAccountFormButton({super.key});

  @override
  State<SocialAccountFormButton> createState() =>
      _SocialAccountFormButtonState();
}

class _SocialAccountFormButtonState extends State<SocialAccountFormButton>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: _toggleExpand,
          child: Container(
            width: 300, // Button width
            height: 63, // Button height
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(9),
              color: Colors.deepOrange,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle, // Choose an appropriate icon
                        color: Colors.black,
                        size: 45,
                      ),
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        "Social Account",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(
                    _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration:
              const Duration(milliseconds: 500), // Smooth transition duration
          curve: Curves.fastOutSlowIn, // Smooth curve for animation
          child: _isExpanded
              ? Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(
                            milliseconds: 300), // Fade-in duration
                        opacity: _isExpanded ? 1.0 : 0.0,
                        child: const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 54,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 108,
                                ),

                                // Adjust the avatar size as needed
                              ),
                            ),
                            SizedBox(height: 21),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: EmailTextfield(),
                            ),
                            SizedBox(height: 21),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: UsernameTextfield(),
                            ),
                            SizedBox(height: 21),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: BioTextfield(),
                            ),
                            SizedBox(height: 21),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: PasswordTextfield(),
                            ),
                            SizedBox(height: 21),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: SignUpButton(),
                            )
                            // Add more fields here if needed
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
