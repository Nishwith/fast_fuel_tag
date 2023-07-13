import 'package:fast_fuel_tag/screens/fileUpload.dart';
// import 'package:fast_fuel_tag/screens/fileview.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const FileUpload(),
    );
  }
}
