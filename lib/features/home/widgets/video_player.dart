import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File file;

  const VideoPlayerWidget({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                VideoPlayer(_controller),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                  child: _controller.value.isPlaying
                      ? Container()
                      : Icon(
                          Icons.play_arrow,
                          size: 108,
                          color: JColors.primaryColor,
                        ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
