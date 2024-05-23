import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:jusso_2024_file/features/profile/screens/upload/create_post_screen.dart';
import 'package:jusso_2024_file/utils/constants/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadScreen extends StatefulWidget {
  final File file;

  const UploadScreen({Key? key, required this.file}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool _isVideo = false;
  VideoPlayerController? _videoController;
  Uint8List? _thumbnail;

  @override
  void initState() {
    super.initState();
    _isVideo = widget.file.path.endsWith('.mp4');
    if (_isVideo) {
      _initializeVideoController(); // Initialize video controller only for video files
    }
    _printFileType();
    _generateThumbnail();
  }

  void _printFileType() {
    print('File Type: ${widget.file.path.split('.').last}');
  }

  void _initializeVideoController() {
    _videoController = VideoPlayerController.file(widget.file);
    _videoController!.initialize().then((_) {
      setState(() {}); // Refresh UI after video controller initialization
    });
  }

  Future<void> _generateThumbnail() async {
    try {
      if (_isVideo) {
        final thumbnail = await VideoThumbnail.thumbnailData(
          video: widget.file.path,
          imageFormat: ImageFormat.PNG,
          maxWidth: 200,
          quality: 80,
        );

        setState(() {
          _thumbnail = thumbnail;
        });
      } else {
        final result = await FlutterImageCompress.compressWithFile(
          widget.file.path,
          quality: 80,
          minWidth: 200,
          minHeight: 200,
        );
        setState(() {
          _thumbnail = result;
        });
      }
    } catch (e) {
      print("Error generating thumbnail: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Upload',
            style: TextStyle(color: JColors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _isVideo && _videoController != null
                  ? Stack(
                      children: [
                        VideoPlayer(_videoController!),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _videoController!.value.isPlaying
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: JColors.primaryColor,
                                      ),
                                      onPressed: () {
                                        _videoController!.pause();
                                      },
                                      child: Icon(Icons.pause,
                                          color: Colors.white),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: JColors.primaryColor,
                                      ),
                                      onPressed: () {
                                        _videoController!.play();
                                      },
                                      child: Icon(Icons.play_arrow,
                                          color: Colors.white),
                                    ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: JColors.primaryColor,
                                ),
                                onPressed: () {
                                  _videoController!.seekTo(Duration.zero);
                                  _videoController!.play();
                                },
                                child: Icon(Icons.restart_alt,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : _thumbnail != null
                      ? Image.memory(_thumbnail!)
                      : Image.file(widget.file),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: JColors.primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePostScreen(
                      file: widget.file,
                      thumbnail: _thumbnail,
                    ),
                  ),
                );
              },
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
