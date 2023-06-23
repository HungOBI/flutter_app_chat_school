// ignore_for_file: unused_field, unused_local_variable, library_private_types_in_public_api, unnecessary_string_interpolations, unnecessary_cast, use_build_context_synchronously

import 'package:app_chat/screen/auth/change_password.dart';
import 'package:app_chat/screen/auth/login_screen.dart';
import 'package:app_chat/screen/groupChat/group_chat_screen.dart';
import 'package:app_chat/screen/profile/profile_screen.dart';
import 'package:app_chat/screen/quiz/quiz_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../quiz/score_screen.dart';
import 'custom_home/custom_card_homescreen.dart';
import 'helper/helper_foundation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _username = '';
  late String _class = '';
  late String _userImage = '';
  late String _rollNo = '';
  late String _academicYear = '';
  late bool _isLoading = true;
  static int i = 0;
  @override
  void initState() {
    super.initState();

    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 69, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi $_username',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              'Class $_class || Roll no: $_rollNo',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(189, 185, 185, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 84,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "$_academicYear",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 58,
                              backgroundImage:
                                  NetworkImage(_userImage) as ImageProvider,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 50,
                        left: 16,
                        right: 16,
                        bottom: 15,
                      ),
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          customCard(
                            text: 'Play Quiz',
                            imagePath: 'assets/images/ic_quiz_home.png',
                            onTap: () {
                              i++;
                              if (i <= 1) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const QuizScreen()),
                                );
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ScoreScreen()),
                                );
                              }
                            },
                          ),
                          customCard(
                            text: 'Assignment',
                            imagePath: 'assets/images/ic_assignment.png',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen()));
                            },
                          ),
                          customCard(
                              text: 'School Holiday',
                              imagePath: 'assets/images/ic_results_home.png'),
                          customCard(
                              text: 'Time Table',
                              imagePath: 'assets/images/ic_calendra_home.png'),
                          customCard(
                              text: 'Result',
                              imagePath: 'assets/images/ic_results_home.png'),
                          customCard(
                              text: 'Date Sheet',
                              imagePath:
                                  'assets/images/ic_date_sheet_home.png'),
                          customCard(
                            text: 'Ask Doubts',
                            imagePath: 'assets/images/ic_doubts_home.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GroupChatScreen()),
                              );
                            },
                          ),
                          customCard(
                              text: 'School Gallery',
                              imagePath: 'assets/images/ic_gallery_home.png'),
                          customCard(
                              text: 'Leave Application',
                              imagePath: 'assets/images/ic_leave_home.png'),
                          customCard(
                            text: 'Change Password',
                            imagePath: 'assets/images/ic_password_home.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePasswordScreen()),
                              );
                            },
                          ),
                          customCard(
                              text: 'Events',
                              imagePath:
                                  'assets/images/ic_date_sheet_home.png'),
                          customCard(
                              text: 'Logout',
                              imagePath: 'assets/images/ic_logout_home.png',
                              onTap: () {
                                logout(context);
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void logout(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    // Clear login history
    await HelperFunctions.saveUserLoggedInStatus(false);
    await HelperFunctions.saveUserNameSF('');
    await HelperFunctions.saveUserEmailSF('');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void getUserData() async {
    String? userEmail = FirebaseAuth.instance.currentUser!.email;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;
      String userName = userSnapshot.get('name');
      String userClass = userSnapshot.get('class');
      String userImage = userSnapshot.get('image');
      String userRollNo = userSnapshot.get('roll_no');
      String userAcademicYear = userSnapshot.get('academic_year');
      setState(() {
        _username = userName;
        _class = userClass;
        _userImage = userImage;
        _rollNo = userRollNo;
        _academicYear = userAcademicYear;
        _isLoading = false;
      });
    }
  }
}
