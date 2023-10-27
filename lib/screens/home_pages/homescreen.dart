import 'package:fastfueltag/screens/home_pages/recharge.dart';
import 'package:fastfueltag/screens/home_pages/vehicles_page.dart';
import 'package:fastfueltag/screens/vehicle_registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;

  const HomeScreen({Key? key, required this.initialIndex}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  final items = const [
    Icon(
      Icons.library_add_outlined,
      color: Colors.purple,
      size: 40,
    ),
    Icon(
      Icons.home_filled,
      color: Colors.purple,
      size: 40,
    ),
    Icon(
      Icons.attach_money,
      color: Colors.purple,
      size: 40,
    ),
  ];

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
        color: const Color.fromARGB(255, 240, 240, 240),
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
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const RegistrationPage();
        break;
      case 1:
        widget = const YourVehicles();
        break;
      case 2:
        widget = const Recharge();
        break;
      default:
        widget = const YourVehicles();
        break;
    }
    return widget;
  }
}
