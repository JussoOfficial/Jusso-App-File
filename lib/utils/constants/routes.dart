import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/authentication/screens/forgotpassword/forgotpasswordform.dart';
import 'package:jusso_2024_file/features/authentication/screens/login/login.dart';
import 'package:jusso_2024_file/features/authentication/screens/signup/signup.dart';
import 'package:jusso_2024_file/features/dashboard/screens/dashboard.dart';
import 'package:jusso_2024_file/features/profile/screens/profile/jusso_feed_list_viewer.dart';

class JRoutes {
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String forgotPassword = '/forgotpassword';
  static const String dashboard = '/dashboard';
  static const String billing = '/billing';
  static const String feedlistviewer = '/ feedlistviewer';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case dashboard:
        return MaterialPageRoute(
            builder: (_) => const DashboardPage(
                  initialIndex: 0,
                ));

      case feedlistviewer:
        return MaterialPageRoute(builder: (_) => const FeedListViewer());

      // ignore: constant_pattern_never_matches_value_type
    }
    return null;
  }

  // Method to navigate to login screen
  static void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}
