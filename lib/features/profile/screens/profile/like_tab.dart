import 'package:flutter/material.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

// LIKED TAB

class LikesTab extends StatelessWidget {
  const LikesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite_border,
          size: 40,
          color: JColors.primaryColor,
        ),
        SizedBox(height: 8),
        Text(
          'No liked videos yet',
          style: TextStyle(
            color: JColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
