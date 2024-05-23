//CONTENT WIDGETS

//FOLLOWING CONTENT WIDGET

import 'package:flutter/material.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

class FollowingContentWidget extends StatefulWidget {
  const FollowingContentWidget({super.key});

  @override
  State<FollowingContentWidget> createState() => _FollowingContentWidgetState();
}

class _FollowingContentWidgetState extends State<FollowingContentWidget> {
  // LIKE FUNCTION
  bool isFavorite = false;
  Color favoriteIconColor = Colors.white;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      favoriteIconColor = isFavorite ? JColors.primaryColor : Colors.white;
    });
  }

//COMMENT BOX
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: const [
              Text(
                'Comments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'No comments yet',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //SHARE BOX AND FUNCTION
  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const SizedBox(
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Share Options',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Send To ',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                  CircleAvatar(
                    radius: 36,
                  ),
                  CircleAvatar(
                    radius: 36,
                  ),
                  CircleAvatar(
                    radius: 36,
                  ),
                ],
              ),
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24, top: 270), // Adjust the left padding as needed
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 39,
                  ),
                  const SizedBox(height: 21),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                        onTap: () {
                          _toggleFavorite();
                        },
                        child: Icon(Icons.favorite,
                            size: 63, color: favoriteIconColor)),
                  ),
                  const SizedBox(height: 21),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () => _showBottomSheet(context),
                      child: const Icon(Icons.chat_bubble_outline,
                          size: 63, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 21),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () => _showShareBottomSheet(context),
                      child: const Icon(Icons.arrow_forward,
                          size: 63, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              left: 3,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Creator Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Creator Description',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
