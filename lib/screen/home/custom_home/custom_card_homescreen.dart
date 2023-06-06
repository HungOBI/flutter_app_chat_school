import 'package:flutter/material.dart';

Widget customCard(
    {required String text, required String imagePath, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 163,
      height: 132,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 246, 252, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 23),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
