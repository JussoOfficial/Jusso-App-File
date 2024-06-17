import 'package:flutter/material.dart';
import 'package:jusso_o/features/jusso%20dashboard/dashboard/jusso_dashboard.dart';

class SignUpButton extends StatefulWidget {
  const SignUpButton({super.key});

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
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
                builder: (context) => const JussoDashboardScreen()));
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
            'Sign Up',
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
