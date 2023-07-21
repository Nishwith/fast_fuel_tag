import 'dart:ui';

import 'package:ait_project/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg1.jpg'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  // height: MediaQuery.of(context).size.height / 1.099,
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
                      Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 40.0, 0, 30.0),
                          child: Text('Verify Email',
                              style: TextStyle(
                                fontSize: 34.0,
                                // have to add font
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                            image: AssetImage('images/verify.png'),
                            height: 170.0,
                            fit: BoxFit.fill),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                cursorColor: Colors.black,
                                onSaved: (pin1) {},
                                decoration:
                                    const InputDecoration(hintText: "*"),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                cursorColor: Colors.black,
                                onSaved: (pin2) {},
                                decoration:
                                    const InputDecoration(hintText: "*"),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                cursorColor: Colors.black,
                                onSaved: (pin3) {},
                                decoration:
                                    const InputDecoration(hintText: "*"),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                cursorColor: Colors.black,
                                onSaved: (pin4) {},
                                decoration:
                                    const InputDecoration(hintText: "*"),
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Card(
                          color: Colors.black,
                          // margin: EdgeInsets.symmetric(
                          //     vertical: 2.0, horizontal: 25.0),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'VERIFY',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
