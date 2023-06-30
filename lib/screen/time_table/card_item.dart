import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  final String time;
  final int id;
  final String date;
  final String title;
  final String content;
  final bool status;
  final Function(int) onDelete;
  final Function(int, bool) onUpdateStatus;

  const CardItem({
    Key? key,
    required this.time,
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.status,
    required this.onDelete,
    required this.onUpdateStatus,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.status;
    super.initState();
  }

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
            const SizedBox(width: 10),
            Expanded(
              child: Column(
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
            ),
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                  widget.onUpdateStatus(widget.id, isChecked);
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
