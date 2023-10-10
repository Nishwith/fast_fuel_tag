// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fast_fuel_tag/screens/home_pages/homescreen.dart';
import 'package:fast_fuel_tag/screens/user_verification/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fast_fuel_tag/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var password = prefs.getString('password');
    Widget initialScreen;
    if (email != null && password != null) {
      // Perform automatic login using email and password
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        initialScreen = const HomeScreen(
          initialIndex: 1,
        );
      } catch (e) {
        // Handle login error, if any
        initialScreen = const Signin();
      }
    } else {
      initialScreen = const Signin();
    }
    await tester.pumpWidget(MyApp(initialScreen));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
