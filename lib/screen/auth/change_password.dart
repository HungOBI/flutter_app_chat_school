// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, non_constant_identifier_names
import 'package:app_chat/screen/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _retypepasswordController =
      TextEditingController();
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
          'Change Password',
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
              child: Container(
                padding: const EdgeInsets.only(
                    top: 50, left: 30, right: 30, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Old Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(165, 165, 165, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // email
                    TextFormField(
                      controller: _passwordController,
                      obscureText: obscurePassword,
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
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          child: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      'New PassWord',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(165, 165, 165, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    TextFormField(
                      controller: _newpasswordController,
                      obscureText: newObscurePassword,
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
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              newObscurePassword = !newObscurePassword;
                            });
                          },
                          child: Icon(
                            newObscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    const Text(
                      'Retype Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(165, 165, 165, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    TextFormField(
                      controller: _retypepasswordController,
                      obscureText: retypeObscurePassword,
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
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              retypeObscurePassword = !retypeObscurePassword;
                            });
                          },
                          child: Icon(
                            retypeObscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    // forgot password

                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        errorMessage,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(40, 85, 174, 1),
                            Color.fromRGBO(40, 169, 241, 1),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          change_password();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'CHANGE PASSWORD',
                                    style: TextStyle(
                                      color: Color.fromRGBO(253, 253, 253, 1),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Color.fromRGBO(253, 253, 253, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void change_password() async {
    String oldPassword = _passwordController.text;
    String newPassword = _newpasswordController.text;
    String retypePassword = _retypepasswordController.text;

    if (newPassword != retypePassword) {
      setState(() {
        errorMessage = "Passwords do not match.";
      });
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: oldPassword);
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (error) {
      setState(() {
        errorMessage = "Failed to change password. Please try again.";
      });
      print("Password change error: $error");
    }
  }
}
