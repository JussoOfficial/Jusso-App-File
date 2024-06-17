import 'package:flutter/material.dart';
import 'package:jusso_o/features/onboarding%20screens/loading%20onboarding%20screen/loading_screen.dart';

class ResetPasswordButton extends StatefulWidget {
  const ResetPasswordButton({super.key});

  @override
  State<ResetPasswordButton> createState() => _ResetPasswordButtonState();
}

class _ResetPasswordButtonState extends State<ResetPasswordButton> {
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoadingOnboardingScreen()));
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
            'Send Reset Link',
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
