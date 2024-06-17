import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jusso_o/authentication/reset%20password/reset%20password%20screen/link_sent_screen.dart';

class LoadingOnboardingScreen extends StatefulWidget {
  const LoadingOnboardingScreen({super.key});

  @override
  _LoadingOnboardingScreenState createState() =>
      _LoadingOnboardingScreenState();
}

class _LoadingOnboardingScreenState extends State<LoadingOnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 6 seconds
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Define the bounce animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    );

    // Start the animation
    _controller.forward();

    // Navigate to ResetPasswordLinkSentScreen after 6 seconds
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const ResetPasswordLinkSentScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              child: Image.asset(
                'assets/Logo.png',
                width: 100,
                height: 100,
              ),
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_animation.value * 0.2),
                  child: child,
                );
              },
            ),
            const SizedBox(
                height: 30), // Space between logo and progress indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
            ),
            const SizedBox(height: 30),
            Text(
              'Loading...',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
