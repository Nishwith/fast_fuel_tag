// import 'package:fast_fuel_tag/screens/file_upload.dart';
import 'package:ait/faqs.dart';
import 'package:ait/help.dart';
import 'package:ait/registration.dart';
import 'package:flutter/material.dart';

import 'recharge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Fuel Tag',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Faqs(),
    );
  }
}
