import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';


class LectureScreen extends StatefulWidget {
  final String videoUrl;
  final String lectureTitle;
  final String lectureContent;

  LectureScreen({
    required this.videoUrl,
    required this.lectureTitle,
    required this.lectureContent,
  });

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  late VlcPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VlcPlayerController.network(
      'https://www.youtube.com/watch?v=dnB9x3OaSH0',
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.stopRendererScanning();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VlcPlayer(
            controller: _videoPlayerController,
            aspectRatio: 16 / 9,
            placeholder: Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.lectureTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.lectureContent,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
