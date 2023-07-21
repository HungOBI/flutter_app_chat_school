// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/helper_foundation.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: non_constant_identifier_names
  bool obscurePassword = true;
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
    checkLoggedInUser();
  }

  void checkLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(HelperFunctions.userLoggedInKey) ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 63, top: 67, right: 16),
              child: const Image(
                image: AssetImage('assets/images/logo_login_screen.png'),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi Student',
                    style: TextStyle(
                      fontSize: 34,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(189, 185, 185, 1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
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
                      'Mobile Number/Email',
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
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 18,
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(50, 54, 67, 1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(165, 165, 165, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // password
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
                    const SizedBox(height: 40),

                    // button signin
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
                          loginUser();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'SIGN IN',
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
                    const SizedBox(
                      height: 10,
                    ),

                    // forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(49, 49, 49, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await HelperFunctions.saveUserLoggedInStatus(true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Login error, please re-enter email and password!! ';
      });
      print('$e');
    }
  }
}
