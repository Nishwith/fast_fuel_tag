import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfueltag/screens/home_pages/homescreen.dart';
import 'package:fastfueltag/screens/user_verification/SignUpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String phoneNum;
  final String userName;

  const VerificationScreen(
      {Key? key,
      required this.email,
      required this.phoneNum,
      required this.userName})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bgImg.png'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(61),
                        topRight: Radius.circular(61),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 40.0, 0, 30.0),
                          child: Text('Verify Email',
                              style: TextStyle(
                                fontSize: 34.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                            image: AssetImage('assets/images/verify.png'),
                            height: 170.0,
                            fit: BoxFit.fill),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Text(
                                "A verification email has been sent to ${widget.email}.",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.currentUser
                                    ?.reload();
                                if (FirebaseAuth
                                        .instance.currentUser?.emailVerified ==
                                    true) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .set({
                                    'userName': widget.userName,
                                    'phoneNum': widget.phoneNum,
                                    'email': widget.email,
                                    'balanceAmount': 0
                                  });
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                                initialIndex: 1,
                                                key: UniqueKey(),
                                              )));
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Email is not verified. Please Create acoount again.")),
                                  );
                                  FirebaseAuth.instance.currentUser?.delete();
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                }
                              },
                              child: const Text("Check Verification Status"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
