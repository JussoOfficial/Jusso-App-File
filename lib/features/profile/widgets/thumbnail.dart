import 'package:flutter/material.dart';

class ThumbnailWidget extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const ThumbnailWidget({
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
