import 'package:fast_fuel_tag/screens/user_verification/reusable.dart';
import 'package:fast_fuel_tag/screens/user_verification/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
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
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline,
                        false, _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _resetPassword(context);
                      },
                      child: const Text("Send Mail"),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailTextController.text);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent successfully!'),
          duration: Duration(seconds: 3),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Signin()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User Not Found!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
