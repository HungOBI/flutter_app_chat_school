import 'package:flutter/material.dart';

Widget buildLessonCard(String lessonName, String teacher, String content) {
  return Card(
    color: const Color.fromRGBO(101, 116, 211, 1.0),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lessonName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Teacher: $teacher',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Lesson content: $content',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
