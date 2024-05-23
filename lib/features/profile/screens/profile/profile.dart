import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/common/common_widgets.dart';
import 'package:jusso_2024_file/features/profile/controllers/profile_controller.dart';
import 'package:jusso_2024_file/features/profile/screens/profile/feed_post_tab.dart';
import 'package:jusso_2024_file/features/profile/screens/settings/settings.dart';
import 'package:jusso_2024_file/features/profile/widgets/buttons/create_post_button.dart';
import 'package:jusso_2024_file/features/profile/widgets/follower_following.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
              )
            ],
          ),
          body: FutureBuilder(
            future: _profileController.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                final user = _profileController.currentUser.value;
                final userProfile = _profileController.userProfile.value;

                if (user != null && userProfile != null) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  userProfile['profileImage'] ?? ''),
                              radius: 63,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        userProfile['username'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.verified,
                                        color: JColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    userProfile['bio'] ?? '',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  const EditProfileButton(),
                                  const SizedBox(height: 10),
                                  CreatePostButton(),
                                  const SizedBox(height: 10),
                                  FollowerFollowingCounterWidget(
                                    followers: int.tryParse(
                                            userProfile['followers'] ?? '0') ??
                                        0,
                                    following: int.tryParse(
                                            userProfile['followings'] ?? '0') ??
                                        0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const TabBar(
                        indicatorColor: JColors.primaryColor,
                        tabs: [
                          Tab(
                            icon: Icon(
                              Icons.grid_view,
                              color: JColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: const TabBarView(
                          children: [
                            FeedTab(),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
