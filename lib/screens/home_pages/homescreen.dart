import 'package:fast_fuel_tag/screens/file_locker/file_locker.dart';
import 'package:fast_fuel_tag/screens/file_locker/file_upload.dart';
import 'package:fast_fuel_tag/screens/file_locker/file_view.dart';
import 'package:fast_fuel_tag/screens/home_pages/recharge.dart';
import 'package:fast_fuel_tag/screens/home_pages/vehicles_page.dart';
import 'package:fast_fuel_tag/screens/vehicle_registration/registration.dart';
import 'package:fast_fuel_tag/screens/home_pages/transaction.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.cover),
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
        widget = const FileLocker();
        break;
      case 1:
        widget = const RegistrationPage();
        break;
      case 2:
        widget = const TranactionPage();
        break;
      case 3:
        widget = const Recharge();
        break;
      case 4:
        widget = const FileUpload();
        break;
      case 5:
        widget = const fileView();
        break;
      case 6:
        widget = const YourVehicles();
        break;
      default:
        widget = const FileLocker();
        break;
    }
    return widget;
  }
}
