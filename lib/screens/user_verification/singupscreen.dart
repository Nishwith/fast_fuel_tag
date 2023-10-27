import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfueltag/screens/user_verification/reusable.dart';
import 'package:fastfueltag/screens/user_verification/verification_page.dart';
import 'package:flutter/material.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpeg'),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                    child: Column(children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter UserName", Icons.person_outline,
                          false, _userNameTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                          "Enter Phone Number",
                          Icons.phone_android_outlined,
                          false,
                          _phoneNumController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Enter Email Id", Icons.mail_outline,
                          false, _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Create Password", Icons.lock_outlined,
                          true, _passwordTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      firebaseUIButton(context, "Sign Up", () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          );
                          await userCredential.user?.sendEmailVerification();
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerificationScreen(
                                email: _emailTextController.text,
                                phoneNum: _phoneNumController.text,
                                userName: _userNameTextController.text[0]
                                        .toUpperCase() +
                                    _userNameTextController.text.substring(1),
                              ),
                            ),
                          );
                        } catch (error) {
                          return null;
                        }
                      }),
                    ])))));
  }
}
