import 'package:flutter/material.dart';

// FOLLOWER FOLLOWING COUNTER WIDGET
class FollowerFollowingCounterWidget extends StatelessWidget {
  final int followers;
  final int following;

  const FollowerFollowingCounterWidget({
    super.key,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCounterItem('Followers', followers),
        _buildCounterItem('Following', following),
      ],
    );
  }

  Widget _buildCounterItem(String label, int count) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          count.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
