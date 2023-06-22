// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  bool obscurePassword = true;
  bool newObscurePassword = true;
  bool retypeObscurePassword = true;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 85, 174, 1),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 12,
              left: 0,
              right: 5,
              bottom: 8,
            ),
            height: 28,
            width: 86,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: const Center(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                    child: Icon(
                      Icons.check,
                      color: Color.fromRGBO(40, 85, 174, 1),
                    ),
                  ),
                  Text(
                    "DONE",
                    style: TextStyle(
                      color: Color.fromRGBO(40, 85, 174, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 36),
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16, left: 18, right: 18),
              height: 99,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: const Color.fromRGBO(40, 85, 174, 1),
                    width: 1,
                  )),
              child: Row(
                children: [
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
