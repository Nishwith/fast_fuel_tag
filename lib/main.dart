import 'package:fastfueltag/firebase_options.dart';
import 'package:fastfueltag/screens/home_pages/homescreen.dart';
import 'package:fastfueltag/screens/user_verification/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      // Handle login error, if any
      initialScreen = const Signin();
    }
  } else {
    initialScreen = const Signin();
  }

  runApp(MyApp(initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp(this.initialScreen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Fuel Tag',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: initialScreen,
    );
  }
}
