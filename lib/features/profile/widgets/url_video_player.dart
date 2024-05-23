import 'package:flutter/material.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:video_player/video_player.dart';

class UrlVideoPlayerWidget extends StatefulWidget {
  final String feedpostMediaUrl;

  UrlVideoPlayerWidget({required this.feedpostMediaUrl});

  @override
  _UrlVideoPlayerWidgetState createState() => _UrlVideoPlayerWidgetState();
}

class _UrlVideoPlayerWidgetState extends State<UrlVideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.feedpostMediaUrl);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
    });
    _controller.addListener(_videoListener);
  }

  void _videoListener() {
    final bool isPlaying = _controller.value.isPlaying;
    if (isPlaying != _isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    }
    if (_controller.value.isCompleted) {
      _controller.seekTo(Duration.zero);
      _controller.play();
    }
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
          return Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              _isPlaying
                  ? SizedBox()
                  : IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: 48,
                      onPressed: () {
                        setState(() {
                          _controller.play();
                          _isPlaying = true;
                        });
                      },
                    ),
              _isPlaying
                  ? SizedBox()
                  : Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller.play();
                            _isPlaying = true;
                          });
                        },
                      ),
                    ),
              _isPlaying
                  ? SizedBox()
                  : Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller.play();
                            _isPlaying = true;
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
            ],
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: JColors.primaryColor,
          ));
        }
      },
    );
  }
}
