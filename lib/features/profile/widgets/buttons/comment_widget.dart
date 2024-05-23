import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/features/profile/controllers/feed_tab_controller.dart';

// REFRACTOR CODE TO TAKE POST ID FROM FEED LIST VIEWER AS PARAMETER
class CommentWidget extends StatefulWidget {
  final String postId;

  const CommentWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  List<Map<String, dynamic>> _comments = [];
  final FeedTabController _feedTabController = Get.find<FeedTabController>();

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      List<Map<String, dynamic>> comments =
          await _feedTabController.fetchCommentsForPost(widget.postId);
      setState(() {
        _comments = comments;
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  // ADD FETCH COMMENTS FROM FOR YOU AND FOLLOWING COMMENTS COLLECTION HERE

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _comments.map((comment) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    comment['username'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                comment['comment'],
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      ),
    );
  }
}
