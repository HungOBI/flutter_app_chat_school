// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, non_constant_identifier_names, unnecessary_string_interpolations, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final TextEditingController _adharNo = TextEditingController();
  final TextEditingController _academicYear = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _parmanentAdd = TextEditingController();
  bool isEditable = true;
  bool Editable = false;

  late String _username = '';
  late String _class = '';
  late String _userImage = '';
  late String _rollNo = '';
  late bool _isLoading = true;

  File? _newImage;

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
                  child: TextButton(
                    onPressed: () {
                      _updateUserData();
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Color.fromRGBO(40, 85, 174, 1),
                        ),
                        SizedBox(
                          width: 5,
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
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 18, left: 18, right: 18, bottom: 0),
                  child: Column(
                    children: [
                      Container(
                        height: 99,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: const Color.fromRGBO(40, 85, 174, 1),
                              width: 1,
                            )),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(12, 12, 17, 12),
                          child: Row(
                            children: [
                              Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(width: 2),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    _userImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$_username',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Text(
                                      'Class $_class || Roll no: $_rollNo',
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _openImagePicker();
                                },
                                icon: const Icon(Icons.camera_alt),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      buildFormField(_adharNo, 'Adhar No', isEditable),
                      const SizedBox(
                        height: 30,
                      ),
                      buildFormField(
                          _academicYear, 'Academic Year', isEditable),
                      const SizedBox(
                        height: 30,
                      ),
                      buildFormField(_email, 'Email', Editable),
                      const SizedBox(
                        height: 30,
                      ),
                      buildFormField(_fullName, 'Full Name', Editable),
                      const SizedBox(
                        height: 30,
                      ),
                      buildFormField(_dateOfBirth, 'Date of Birth', Editable),
                      const SizedBox(
                        height: 30,
                      ),
                      buildFormField(
                          _parmanentAdd, 'Karol Bagh,Delhi', Editable),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _newImage = File(pickedImage.path);
      });

      await _uploadAndSetNewImage();
    }
  }

  Future<void> _uploadAndSetNewImage() async {
    String? userEmail = FirebaseAuth.instance.currentUser!.email;
    String oldImage = _userImage;
    String newImagePath = '${DateTime.now()}.png';
    final Reference storageRef =
        FirebaseStorage.instance.ref().child(newImagePath);
    final UploadTask uploadTask = storageRef.putFile(_newImage!);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await taskSnapshot.ref.getDownloadURL();
    if (oldImage.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(oldImage).delete();
    }
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;
      await userSnapshot.reference.update({
        'image': imageUrl,
      });
    }
    setState(() {
      _userImage = imageUrl;
    });
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
      String userAdharNo = userSnapshot.get('adhar_no');
      String userAdress = userSnapshot.get('adress');
      String userDateOfBirth = userSnapshot.get('date_of_birth');
      String userFullName = userSnapshot.get('full_name');
      String userEmail = userSnapshot.get('email');
      setState(() {
        _username = userName;
        _class = userClass;
        _userImage = userImage;
        _rollNo = userRollNo;
        _adharNo.text = userAdharNo;
        _academicYear.text = userAcademicYear;
        _email.text = userEmail;
        _fullName.text = userFullName;
        _dateOfBirth.text = userDateOfBirth;
        _parmanentAdd.text = userAdress;
        _isLoading = false;
      });
    }
  }

  void _updateUserData() async {
    String? userEmail = FirebaseAuth.instance.currentUser!.email;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;

      String newAdharNo = _adharNo.text;
      String newAcademicYear = _academicYear.text;

      await userSnapshot.reference.update({
        'adhar_no': newAdharNo,
        'academic_year': newAcademicYear,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update information successfully!')),
        );
      });
    }
  }
}
