import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String time;
  final String date;
  final String title;
  final String content;
  final String status;

  const CardItem({
    Key? key,
    required this.time,
    required this.date,
    required this.title,
    required this.content,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(content),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.check_box),
              onPressed: () {
                //
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                //
              },
            ),
          ],
        ),
      ),
    );
  }
}
