import 'dart:ui';

import 'package:ait_project/homescreen/homescreen.dart';
import 'package:ait_project/reusable/reusable.dart';
import 'package:ait_project/screens/singupscreen.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpeg'), fit: BoxFit.cover),
        ),
        child: Column(children: <Widget>[
          Center(
            child: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(Colors.transparent, BlendMode.color),
              child: Padding(
                padding: EdgeInsets.fromLTRB(60.0, 30.0, 60.0, 0),
                child: Image(
                  image: AssetImage('images/logoo.png'),
                ),
              ),
            ),
          ),
          Center(
              child: Text(
            "FAST FUEL TAG",
            style: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          )),
          // SingleChildScrollView(
          //   physics: const BouncingScrollPhysics(),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 20),
          //     child: ClipRect(
          //       child: BackdropFilter(
          //         filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          //         child: Container(
          //           height: 500.2,
          //           clipBehavior: Clip.antiAlias,
          //           decoration: ShapeDecoration(
          //             color: const Color.fromARGB(255, 255, 255, 255)
          //                 .withOpacity(0.5),
          //             shape: RoundedRectangleBorder(
          //               side: BorderSide(
          //                 width: 2,
          //                 color: Colors.white.withOpacity(0.25),
          //               ),
          //               borderRadius: const BorderRadius.only(
          //                 topLeft: Radius.circular(61),
          //                 topRight: Radius.circular(61),
          //               ),
          //             ),
          //           ),
          //           child: Column(
          //             children: <Widget>[
          //               Center(
          //                 child: Padding(
          //                   padding: EdgeInsets.fromLTRB(0, 30.0, 0, 20.0),
          //                   child: Text("Welcome!",
          //                       style: TextStyle(
          //                         fontSize: 34.0,
          //                         fontWeight: FontWeight.w700,
          //                         color: Colors.white,
          //                       )),
          //                 ),
          //               ),
          //               TextButton(
          //                 onPressed: () {},
          //                 child: Column(
          //                   children: <Widget>[
          //                     reusableTextField(
          //                         "Enter UserName or email ",
          //                         Icons.person_outline,
          //                         false,
          //                         _emailTextController),
          //                     const SizedBox(
          //                       height: 20,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          reusableTextField("Enter UserName or email ", Icons.person_outline,
              false, _emailTextController),
          const SizedBox(
            height: 25,
          ),
          reusableTextField("Enter Password", Icons.lock_outline, true,
              _passwordTextController),
          const SizedBox(
            height: 20,
          ),
          firebaseUIButton(context, "Sign In", () {
            // FirebaseAuth.instance
            //  .signInWithEmailAndPassword(
            //email: _emailTextController.text,
            // password: _passwordTextController.text)
            //.then((value) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }),
          const SizedBox(
            height: 10,
          ),
          signUpOption(),
        ]),
      ),
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
                MaterialPageRoute(builder: (context) => SingupScreen()));
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
