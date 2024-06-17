import 'package:flutter/material.dart';
import 'package:jusso_o/authentication/login/login%20screen/login_screen.dart';

class BackToLoginButton extends StatefulWidget {
  const BackToLoginButton({super.key});

  @override
  State<BackToLoginButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<BackToLoginButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 300.0, // Set the desired width of the container
        height: 54.0, // Set the desired height of the container
        padding:
            const EdgeInsets.symmetric(vertical: 12.0), // Add vertical padding
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(8), // Adjust border radius if needed
          color: _isTapped ? Colors.deepOrange.shade700 : Colors.deepOrange,
          // Use darker shade of orange when tapped
          shape: BoxShape.rectangle,
        ),
        child: const Center(
          child: Text(
            ' Go Back to Login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0, // Adjust font size if needed
            ),
          ),
        ),
      ),
    );
  }
}
