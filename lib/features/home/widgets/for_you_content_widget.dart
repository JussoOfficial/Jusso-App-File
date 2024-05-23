import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jusso_2024_file/features/home/controllers/for_you_controller.dart';
import 'package:jusso_2024_file/features/home/models/home_model.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:video_player/video_player.dart';

class ForYouContentWidget extends StatefulWidget {
  const ForYouContentWidget({Key? key}) : super(key: key);

  @override
  State<ForYouContentWidget> createState() => _ForYouContentWidgetState();
}

class _ForYouContentWidgetState extends State<ForYouContentWidget> {
  final ForYouController _controller = Get.put(ForYouController());
  final TextEditingController _commentController = TextEditingController();
  String? _username;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    String userId = _controller.currentUser?.uid ?? 'unknown';
    if (userId != 'unknown') {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('SocialUsers')
          .doc(userId)
          .get();
      await FirebaseFirestore.instance
          .collection('BusinessUsers')
          .doc(userId)
          .get();
      print('username: ${userDoc.data()?['username']}');
      setState(() {
        _username = userDoc.data()?['username'] ?? 'unknown';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot<Map<String, Object?>>>>(
      future: _controller.fetchContentForCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: JColors.primaryColor),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No content available');
          return const Center(child: Text('No content available'));
        }

        return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var doc = snapshot.data![index];
            var data = doc.data();

            String mediaUrl = data['mediaUrl'] as String;

            return FutureBuilder<String>(
              future: _controller.getMediaType(mediaUrl),
              builder: (context, mediaTypeSnapshot) {
                if (mediaTypeSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(color: JColors.primaryColor),
                  );
                }

                if (!mediaTypeSnapshot.hasData ||
                    mediaTypeSnapshot.data == 'unknown') {
                  return const Center(child: Text('Unable to load media'));
                }

                String mediaType = mediaTypeSnapshot.data!;
                String creatorName = data['creatorName'] as String;
                String contentDescription =
                    data['contentDescription'] as String;
                String postId = data['postId'] as String;

                return Container(
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: mediaType == 'video'
                            ? VideoPlayerWidget(mediaUrl: mediaUrl)
                            : Image.network(mediaUrl, fit: BoxFit.cover),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              creatorName,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 185, 184, 184),
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                            Text(
                              contentDescription,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                const CircleAvatar(
                                  radius: 39,
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: JColors.primaryColor,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 21,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () => _likePost(postId),
                                child: Icon(
                                  Icons.favorite,
                                  size: 45,
                                  color: favoriteIconColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () => _showBottomSheet(context, postId),
                                child: const Icon(Icons.chat_bubble_outline,
                                    size: 45, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () => _showShareBottomSheet(context),
                                child: const Icon(Icons.arrow_forward,
                                    size: 45, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  bool isFavorite = false;
  Color favoriteIconColor = const Color.fromARGB(255, 135, 131, 131);

  void _likePost(String postId) {}

  void _showBottomSheet(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Ensure the keyboard doesn't push the bottom sheet up
      builder: (BuildContext context) {
        return CommentBottomSheet(
          postId: postId,
          commentController: _commentController,
          uploadComment: _uploadComment,
          username: _username ?? 'unknown',
        );
      },
    );
  }

  void _uploadComment(String postId, String username) {
    String commentText = _commentController.text;
    if (commentText.isNotEmpty) {
      String userId = _controller.currentUser?.uid ?? 'unknown';
      FirebaseFirestore.instance
          .collection('Content')
          .doc('ForYou & Following')
          .collection('For You and Following Comments')
          .add({
        'postId': postId,
        'comment': commentText,
        'timestamp': Timestamp.now(),
        'userId': userId,
        'username': username,
      });
      _commentController.clear();
      Navigator.pop(context);
    }
  }

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
            ],
          ),
        );
      },
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String mediaUrl;

  const VideoPlayerWidget({Key? key, required this.mediaUrl}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.mediaUrl)
      ..initialize().then((_) {
        setState(() {
          _videoController.play();
        });

        _videoController.addListener(() {
          if (_videoController.value.position ==
              _videoController.value.duration) {
            _videoController.seekTo(Duration.zero);
            _videoController.play();
          }
        });
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          )
        : const Center(
            child: CircularProgressIndicator(
            color: JColors.primaryColor,
          ));
  }
}

// Comment Bottom Sheet
class CommentBottomSheet extends StatefulWidget {
  final String postId;
  final TextEditingController commentController;
  final Function(String, String) uploadComment;
  final String username;

  const CommentBottomSheet({
    Key? key,
    required this.postId,
    required this.commentController,
    required this.uploadComment,
    required this.username,
  }) : super(key: key);

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  late Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = Get.find<ForYouController>().fetchComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<
                List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
              future: _commentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(color: JColors.primaryColor),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No comments available for this post'));
                }

                List<QueryDocumentSnapshot<Map<String, dynamic>>> comments =
                    snapshot.data!
                        .cast<QueryDocumentSnapshot<Map<String, dynamic>>>();

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    CommentModel comment =
                        CommentModel.fromMap(comments[index].data());
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        title: Text(
                          comment.username,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                        subtitle: Text(
                          comment.comment,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: JColors.primaryColor),
                  onPressed: () =>
                      widget.uploadComment(widget.postId, widget.username),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
