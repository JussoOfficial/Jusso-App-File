import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jusso_2024_file/features/profile/controllers/feed_tab_controller.dart';
import 'package:jusso_2024_file/features/profile/widgets/buttons/comment_widget.dart';
import 'package:jusso_2024_file/features/profile/widgets/url_video_player.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';

// REFRACTOR CODE TO

// SEND POST ID PARAMETER TO
// BUBBLE CHAT IOCN
// FAVORITE ICON
// ARROW FORWARD ICON
// COMMENT WIDGET
class FeedListViewer extends StatefulWidget {
  const FeedListViewer({Key? key}) : super(key: key);

  @override
  _FeedListViewerState createState() => _FeedListViewerState();
}

class _FeedListViewerState extends State<FeedListViewer> {
  List<Map<String, dynamic>> _feedPosts = [];
  FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _fetchFeedPosts();
  }

  Future<void> _fetchFeedPosts() async {
    try {
      List<Map<String, dynamic>> feedPosts =
          await FeedTabController().fetchFeedPostsForCurrentUser();
      setState(() {
        _feedPosts = feedPosts;
      });
    } catch (e) {
      print('Error fetching feed posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        titleTextStyle: const TextStyle(
            color: JColors.black, fontFamily: 'Karla', fontSize: 21),
      ),
      body: ListView.builder(
        itemCount: _feedPosts.length,
        itemBuilder: (context, index) {
          return _buildFeedItem(_feedPosts[index]);
        },
      ),
    );
  }

  Widget _buildFeedItem(Map<String, dynamic> feedPost) {
    String postId = feedPost['postId'];

    String postUsername = feedPost['postUsername'];
    String postDescription = feedPost['postDescription'];
    int postLikes = feedPost['postLikes'];
    int postComments = feedPost['postComments'];
    int postShares = feedPost['postShares'];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 255, 252, 252),
          width: 0.6,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    postUsername,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Icon(
                Icons.verified,
                color: Colors.deepOrange,
              ),
            ],
          ),
          FutureBuilder<FullMetadata>(
            future: _retrieveMetadata(feedPost['feedpostMediaUrl']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: Colors.deepOrange,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                FullMetadata metadata = snapshot.data!;
                String fileType = metadata.customMetadata?['fileType'] ?? '';
                Widget mediaWidget;
                if (fileType == 'video') {
                  mediaWidget = UrlVideoPlayerWidget(
                      feedpostMediaUrl: feedPost['feedpostMediaUrl']);
                } else {
                  mediaWidget = Image.network(
                    feedPost['feedpostMediaUrl'],
                    fit: BoxFit.cover,
                    height: 600,
                  );
                }
                return mediaWidget;
              }
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                postUsername,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                postDescription,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => _openChatDialog(context, postId),
                  child: _buildIconWithCount(
                      Icons.favorite_border, postLikes, Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => _openChatDialog(context, postId),
                  child: _buildIconWithCount(
                      Icons.chat_bubble_outline, postComments, Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => _openShareDialog(context, postId),
                  child: _buildIconWithCount(
                      Icons.arrow_forward, postShares, Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithCount(IconData iconData, int count, Color color) {
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
          size: 36,
        ),
        SizedBox(width: 3),
        Text('$count'),
      ],
    );
  }

  Future<FullMetadata> _retrieveMetadata(String url) async {
    Reference ref = _storage.refFromURL(url);
    return await ref.getMetadata();
  }

  void _openChatDialog(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Show list of comments that match the postId
              const Text(
                'Comment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'This is a comment dialog.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              CommentWidget(
                postId: postId,
              ),
              const SizedBox(height: 12),
              //CHAT TEXT FIELD
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: JColors.primaryColor),
              ))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: JColors.primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: JColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openShareDialog(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Share',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Share this post.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: JColors.primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: JColors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
