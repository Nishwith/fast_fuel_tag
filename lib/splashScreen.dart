import 'dart:async';

import 'package:fastfueltag/screens/home_pages/homescreen.dart';
import 'package:fastfueltag/screens/user_verification/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialState();
  }

  Future<void> initialState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var password = prefs.getString('password');

    Widget initialScreen;
    if (email != null && password != null) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        initialScreen = HomeScreen(
          initialIndex: 1,
          key: UniqueKey(),
        );
      } catch (e) {
        initialScreen = const Signin();
      }
    } else {
      initialScreen = const Signin();
    }

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => initialScreen));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image(
                image: AssetImage("assets/images/logo.png"),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2),
            CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 51, 0, 255)),
            )
          ],
        ),
      ),
    );
  }
}
