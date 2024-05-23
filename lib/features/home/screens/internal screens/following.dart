import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/home/widgets/following_content_widget.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class FollowingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JColors.black,
      body: PageView(
        children: const [
          FollowingContentWidget(),
        ],
      ),
    );
  }
}
