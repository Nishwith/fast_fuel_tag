import 'dart:ui';
import 'package:fast_fuel_tag/screens/home_pages/homescreen.dart';
import 'package:fast_fuel_tag/screens/home_pages/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class YourVehicles extends StatefulWidget {
  const YourVehicles({super.key});

  @override
  State<YourVehicles> createState() => _YourVehiclesState();
}

class _YourVehiclesState extends State<YourVehicles> {
  bool _showAppBar = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                      iconSize: 30,
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                    ),
                  ],
                  centerTitle: true,
                )
              : PreferredSize(
                  preferredSize: Size.zero,
                  child: Container(),
                ),
          body: Container(
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
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255)
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
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.matrix(
                                              Matrix4.identity()
                                                  .scaled(0.0)
                                                  .storage,
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
                                              decoration: const ShapeDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment(1.00, -0.07),
                                                  end: Alignment(-1, 0.07),
                                                  colors: [
                                                    Color(0xFFB5D0F9),
                                                    Color(0x0085B2F5)
                                                  ],
                                                ), // Change the color to dark black
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFFE1E1E1)),
                                                ),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Image(
                                                  image: AssetImage(
                                                      "assets/images/car.png"),
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
                                                    const TranactionPage(
                                                        vehicleNumber:
                                                            "TS 09 AZ 9999")),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRect(
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10.0, sigmaY: 10.0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                decoration:
                                                    const ShapeDecoration(
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment(0.00, -1.00),
                                                    end: Alignment(0, 1),
                                                    colors: [
                                                      Color(0xFFD289FF),
                                                      Color(0x005E95FF)
                                                    ],
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 0.50,
                                                        color:
                                                            Color(0xFF93A9F7)),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'TS 09 AZ 9999',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRect(
                                              child: BackdropFilter(
                                            filter: ImageFilter.matrix(
                                              Matrix4.identity()
                                                  .scaled(0.0)
                                                  .storage,
                                            ),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
                                              decoration: const ShapeDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment(1.00, -0.07),
                                                  end: Alignment(-1, 0.07),
                                                  colors: [
                                                    Color(0xFFB5D0F9),
                                                    Color(0x0085B2F5)
                                                  ],
                                                ),
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFFE1E1E1)),
                                                ),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Image(
                                                    image: AssetImage(
                                                        "assets/images/bike.png")),
                                              ),
                                            ),
                                          ))),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TranactionPage(
                                                        vehicleNumber:
                                                            "TS 09 AC 7777")),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRect(
                                            child: BackdropFilter(
                                              filter: ImageFilter.matrix(
                                                Matrix4.identity()
                                                    .scaled(0.0)
                                                    .storage,
                                              ),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                decoration:
                                                    const ShapeDecoration(
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment(0.00, -1.00),
                                                    end: Alignment(0, 1),
                                                    colors: [
                                                      Color(0xFFD289FF),
                                                      Color(0x005E95FF)
                                                    ],
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 0.50,
                                                        color:
                                                            Color(0xFF93A9F7)),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'TS 09 AC 7777',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRect(
                                              child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10.0, sigmaY: 10.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
                                              decoration: const ShapeDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment(1.00, -0.07),
                                                  end: Alignment(-1, 0.07),
                                                  colors: [
                                                    Color(0xFFB5D0F9),
                                                    Color(0x0085B2F5)
                                                  ],
                                                ),
                                                shape: OvalBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: Color(0xFFE1E1E1)),
                                                ),
                                              ),
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/scooty.png"),
                                              ),
                                            ),
                                          ))),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TranactionPage(
                                                        vehicleNumber:
                                                            "TS 09 AT 6666")),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRect(
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 10.0, sigmaY: 10.0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    20,
                                                decoration:
                                                    const ShapeDecoration(
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment(0.00, -1.00),
                                                    end: Alignment(0, 1),
                                                    colors: [
                                                      Color(0xFFD289FF),
                                                      Color(0x005E95FF)
                                                    ],
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 0.50,
                                                        color:
                                                            Color(0xFF93A9F7)),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'TS 09 AT 6666',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                          ))),
                ),
              ))),
    );
  }
}
