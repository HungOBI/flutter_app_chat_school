import 'package:flutter/material.dart';

class LectureScreen extends StatelessWidget {
  final String videoUrl;
  final String lectureTitle;
  final String lectureContent;

  LectureScreen({
    required this.videoUrl,
    required this.lectureTitle,
    required this.lectureContent,
  });

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

          Container(
            height: 200,
            color: Colors.grey,

          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              lectureTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              lectureContent,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
