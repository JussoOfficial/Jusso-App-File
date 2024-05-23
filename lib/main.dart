import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jusso_2024_file/features/profile/controllers/profile_controller.dart';
import 'package:jusso_2024_file/firebase_options.dart';
import 'package:jusso_2024_file/utils/constants/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize ProfileController
  Get.put(ProfileController());

  runApp(
    MultiProvider(
      providers: [
        // Add more providers if needed
      ],
      child: const JussoApp(),
    ),
  );
}

class JussoApp extends StatefulWidget {
  const JussoApp({Key? key}) : super(key: key);

  @override
  State<JussoApp> createState() => _JussoAppState();
}

class _JussoAppState extends State<JussoApp> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Check the authentication state asynchronously
      future: _auth.authStateChanges().first,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator while checking authentication state
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          // If user is logged in, navigate to dashboard, else navigate to login page
          final bool isLoggedIn = snapshot.data != null;
          final initialRoute = isLoggedIn ? JRoutes.dashboard : JRoutes.login;
          return GetMaterialApp(
            initialRoute: initialRoute,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: JRoutes.generateRoute,
          );
        }
      },
    );
  }
}
