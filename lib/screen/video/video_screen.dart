import 'package:app_chat/screen/video/custom_card_video.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';

  class VideoScreen extends StatefulWidget {
    const VideoScreen({Key? key}) : super(key: key);

    @override
    State<VideoScreen> createState() => _VideoScreen();
  }

  class _VideoScreen extends State<VideoScreen> {

    late List<Map<String, dynamic>> _lessons = [];

    @override
    void initState() {
      super.initState();

      fetchLessons();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(40, 85, 174, 1),
          title: const Text(
            'Video',
            style: TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: ListView.builder(
                  itemCount: _lessons.length,
                  itemBuilder: (context, index) {
                    return buildLessonCard(
                      _lessons[index]['lessonName'],
                      _lessons[index]['teacher'],
                      _lessons[index]['lessonContent'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

  Future<void> fetchLessons() async {
      try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('lesson')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      List<Map<String, dynamic>> lessons = [];
      for (var doc in querySnapshot.docs) {
        String lessonName = doc.get('lesson_name');
        String teacher = doc.get('teacher');
        String lessonContent = doc.get('lesson_content');

        lessons.add({
          'lessonName': lessonName,
          'teacher': teacher,
          'lessonContent': lessonContent,
        });
      }

      setState(() {
        _lessons = lessons;
      });
    }
  } catch (e) {
    // Handle any potential errors here

  }}

  }
