// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  final String time;
  final int id;
  final String date;
  final String title;
  final String content;
  final String status;
  final Function(int) onDelete;
  const CardItem({
    Key? key,
    required this.time,
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.status,
    required this.onDelete,
  }) : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              widget.time,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(widget.content),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: isChecked
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank),
              onPressed: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.onDelete(widget.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
