import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfueltag/screens/home_pages/view_docs.dart';
import 'package:fastfueltag/screens/home_pages/homescreen.dart';
import 'package:fastfueltag/screens/home_pages/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class YourVehicles extends StatefulWidget {
  const YourVehicles({super.key});

  @override
  State<YourVehicles> createState() => _YourVehiclesState();
}

class _YourVehiclesState extends State<YourVehicles> {
  bool _showAppBar = true;
  bool _isLoading = true;
  int numberOfVehicles = 0;
  Map<String, dynamic>? vehicleDoc;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _fetchVehiclesData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _showAppBar = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _showAppBar = true;
      });
    }
  }

  double heightAdjust() {
    if (numberOfVehicles < 3) {
      return MediaQuery.of(context).size.height - 100;
    } else {
      return numberOfVehicles.toDouble() *
          MediaQuery.of(context).size.height /
          3;
    }
  }

  Future<void> _fetchVehiclesData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        // Fetch the documents from the "vehicles" collection
        QuerySnapshot<Map<String, dynamic>> vehiclesSnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('vehicles')
                .get();

        // Convert the QuerySnapshot into a Map where keys are vehicle numbers
        Map<String, dynamic> vehiclesData = {};
        for (var doc in vehiclesSnapshot.docs) {
          vehiclesData[doc.id] = doc.data();
        }

        // Set the vehicle data to your state variable
        setState(() {
          vehicleDoc = vehiclesData;
          numberOfVehicles = vehiclesData.length;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: _showAppBar
              ? AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: Container(),
                  title: const Text(
                    'Your Vehicles',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'Inter',
                      //we need to add fonts
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  actions: [
                    IconButton(
                        iconSize: 34,
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        })
                  ],
                  centerTitle: true,
                )
              : PreferredSize(
                  preferredSize: Size.zero,
                  child: Container(),
                ),
          drawer: const CustomDrawer(),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/bgImg.png"),
                          fit: BoxFit.cover)),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                      child: ClipRect(
                          child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                  height: heightAdjust(),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color:
                                        const Color.fromARGB(255, 255, 255, 255)
                                            .withOpacity(0.35),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        color: Colors.white.withOpacity(0.4),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(61),
                                        topRight: Radius.circular(61),
                                      ),
                                    ),
                                  ),
                                  child: _buildVehicleWidgets(vehicleDoc)))),
                    ),
                  ))),
    );
  }
}

Widget _buildVehicleWidgets(Map<String, dynamic>? vehicles) {
  if (vehicles == null || vehicles.isEmpty) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            const Text(
              'No vehicles registered!',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(key: UniqueKey(), initialIndex: 0),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                elevation: 5,
                padding: const EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Register Your First Vehicle :)',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      );
    });
  }

  List<Widget> widgets = [];
  vehicles.forEach((vehicleNumber, vehicleData) {
    // Here, vehicleNumber is the document ID, not a field in the document
    String typeCode = vehicleData['typeCode'];

    Widget vehicleWidget;
    if (typeCode == '2') {
      // Scooty
      vehicleWidget = ScootyWidget(vehicleNumber: vehicleNumber);
    } else if (typeCode == '4') {
      // Car
      vehicleWidget = CarWidget(vehicleNumber: vehicleNumber);
    } else if (typeCode == "2G") {
      // Default to Bike if typeCode is not 2 or 4
      vehicleWidget = BikeWidget(vehicleNumber: vehicleNumber);
    } else {
      vehicleWidget = BikeWidget(vehicleNumber: vehicleNumber);
    }

    widgets.add(vehicleWidget);
  });

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: widgets,
  );
}

// Example Widget classes for Car, Scooty, and Bike
class CarWidget extends StatelessWidget {
  final String vehicleNumber;

  const CarWidget({super.key, required this.vehicleNumber});

  @override
  Widget build(BuildContext context) {
    // Implement your CarWidget UI here
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.matrix(
                Matrix4.identity().scaled(0.0).storage,
              ),
              child: Container(
                width: MediaQuery.of(context).size.height / 4.5,
                height: MediaQuery.of(context).size.height / 4.5,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(1.00, -0.07),
                    end: Alignment(-1, 0.07),
                    colors: [Color(0xFFB5D0F9), Color(0x0085B2F5)],
                  ), // Change the color to dark black
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: Color(0xFFE1E1E1)),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Image(
                    image: AssetImage("assets/images/car.png"),
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FileLocker(vehicleNumber: vehicleNumber)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 20,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFD289FF), Color(0x005E95FF)],
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFF93A9F7)),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      vehicleNumber,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ScootyWidget extends StatelessWidget {
  final String vehicleNumber;

  const ScootyWidget({super.key, required this.vehicleNumber});

  @override
  Widget build(BuildContext context) {
    // Implement your ScootyWidget UI here
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.height / 4.5,
                height: MediaQuery.of(context).size.height / 4.5,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(1.00, -0.07),
                    end: Alignment(-1, 0.07),
                    colors: [Color(0xFFB5D0F9), Color(0x0085B2F5)],
                  ),
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: Color(0xFFE1E1E1)),
                  ),
                ),
                child: const Image(
                  image: AssetImage("assets/images/scooty.png"),
                ),
              ),
            ))),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FileLocker(vehicleNumber: vehicleNumber)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 20,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFD289FF), Color(0x005E95FF)],
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFF93A9F7)),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      vehicleNumber,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BikeWidget extends StatelessWidget {
  final String vehicleNumber;

  const BikeWidget({super.key, required this.vehicleNumber});

  @override
  Widget build(BuildContext context) {
    // Implement your BikeWidget UI here
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRect(
                child: BackdropFilter(
              filter: ImageFilter.matrix(
                Matrix4.identity().scaled(0.0).storage,
              ),
              child: Container(
                width: MediaQuery.of(context).size.height / 4.5,
                height: MediaQuery.of(context).size.height / 4.5,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(1.00, -0.07),
                    end: Alignment(-1, 0.07),
                    colors: [Color(0xFFB5D0F9), Color(0x0085B2F5)],
                  ),
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: Color(0xFFE1E1E1)),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Image(image: AssetImage("assets/images/bike.png")),
                ),
              ),
            ))),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FileLocker(vehicleNumber: vehicleNumber)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.matrix(
                  Matrix4.identity().scaled(0.0).storage,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 20,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFFD289FF), Color(0x005E95FF)],
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFF93A9F7)),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      vehicleNumber,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
