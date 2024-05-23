import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/features/profile/controllers/feed_tab_controller.dart';
import 'package:jusso_2024_file/features/profile/screens/profile/jusso_feed_list_viewer.dart';
import 'package:jusso_2024_file/features/profile/widgets/buttons/create_post_button.dart';
import 'package:jusso_2024_file/features/profile/widgets/thumbnail.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedTabController>(
      init: FeedTabController(),
      builder: (controller) {
        return FutureBuilder<List<String>>(
          future: controller.fetchThumbnailUrls(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            List<String> thumbnailUrls = snapshot.data ?? [];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (thumbnailUrls.isEmpty)
                  Column(
                    children: [
                      Icon(
                        Icons.grid_view,
                        size: 40,
                        color: JColors.primaryColor,
                      ),
                      SizedBox(height: 9),
                      Text(
                        'Want to post something?',
                        style: TextStyle(
                          color: JColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 9),
                      CreatePostButton(),
                    ],
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: thumbnailUrls.length,
                      itemBuilder: (context, index) {
                        return ThumbnailWidget(
                          imageUrl: thumbnailUrls[index],
                          onTap: () {
                            // NAVIGATE TO FEED POST LIST VIEW
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FeedListViewer()));
                          },
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
