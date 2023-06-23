import 'package:flutter/material.dart';

Widget buildFormField(
    TextEditingController controller, String text, bool editable) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(165, 165, 165, 1),
          ),
        ),
      ),
      TextFormField(
        controller: controller,
        enabled: editable,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 18,
            ),
          ),
          labelStyle: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(50, 54, 67, 1),
          ),
          suffixIcon: editable ? null : const Icon(Icons.lock),
        ),
      ),
    ],
  );
}
