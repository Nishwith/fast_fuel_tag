import 'package:ait_project/screens/digi/digilockerone.dart';
import 'package:ait_project/screens/recharge/recharge1.dart';
import 'package:ait_project/screens/registration/registration1.dart';
import 'package:ait_project/screens/transaction/transaction.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = const [
    Icon(
      Icons.lock_clock_outlined,
      color: Colors.purple,
      size: 40,
    ),
    Icon(
      Icons.app_registration,
      color: Colors.purple,
      size: 40,
    ),
    Icon(
      Icons.history_rounded,
      color: Colors.purple,
      size: 40,
    ),
    Icon(
      Icons.attach_money,
      color: Colors.purple,
      size: 40,
    ),
  ];

  int index = 1;

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
        child: Container(
            color: Colors.teal.shade500,
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: getSelectedWidget(index: index)),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        height: 50.0,
        backgroundColor: Colors.purple,

        animationDuration: const Duration(milliseconds: 200),
        // animationCurve: ,
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const Digilocker();
        break;
      case 1:
        widget = Registration();
        break;
      case 2:
        widget = const Transaction();
      case 3:
        widget = const Recharge();
      default:
        widget = const Digilocker();
        break;
    }
    return widget;
  }
}
