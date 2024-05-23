import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/features/profile/controllers/settings_controller.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:jusso_2024_file/utils/constants/routes.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key) {
    // Register the SettingsController instance
    Get.put(SettingsController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: FutureBuilder(
          future: Get.find<SettingsController>().getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return GetBuilder<SettingsController>(
                builder: (_settingsController) {
                  if (_settingsController.username != null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Username: ${_settingsController.username}',
                          style: TextStyle(
                            color: JColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Account Type: ${_settingsController.accountType}',
                          style: TextStyle(
                            color: JColors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Status: ${_settingsController.status}',
                          style: TextStyle(
                            color: JColors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _settingsController.signOut();
                            Get.offAllNamed(JRoutes.login);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
