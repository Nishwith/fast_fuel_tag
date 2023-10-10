import 'package:fast_fuel_tag/screens/user_verification/reset.dart';
import 'package:fast_fuel_tag/screens/user_verification/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fast_fuel_tag/screens/home_pages/homescreen.dart';
import 'package:fast_fuel_tag/screens/user_verification/singupscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Center(
                child: ColorFiltered(
                  colorFilter:
                      ColorFilter.mode(Colors.transparent, BlendMode.color),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(60.0, 30.0, 60.0, 0),
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
              ),
              const Center(
                  child: Text(
                "FAST FUEL TAG",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              )),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Enter UserName or email ",
                  Icons.person_outline, false, _emailTextController),
              const SizedBox(
                height: 25,
              ),
              reusableTextField("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              firebaseUIButton(context, "Sign In", () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('email', _emailTextController.text);
                  prefs.setString('password', _passwordTextController.text);

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                initialIndex: 1,
                                key: UniqueKey(),
                              )));
                }).onError((error, stackTrace) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Invalid Password or User Id',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                });
              }),
              const SizedBox(
                height: 10,
              ),
              forgotPassword(),
              const SizedBox(
                height: 20,
              ),
              signUpOption(),
            ],
          ),
        ),
      ),
    );
  }

  Row forgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Forgot the Password?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ResetPassword()));
          },
          child: const Text(
            " Reset Password",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SingupScreen()));
          },
          child: const Text(
            " Create an Account",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
