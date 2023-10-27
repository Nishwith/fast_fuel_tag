import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfueltag/screens/home_pages/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TranactionPage extends StatefulWidget {
  const TranactionPage({Key? key, required this.vehicleNumber})
      : super(key: key);
  final String vehicleNumber;
  @override
  State<TranactionPage> createState() => _TranactionPageState();
}

class _TranactionPageState extends State<TranactionPage> {
  bool _showAppBar = true;
  bool _isLoading = true;
  String userName = '';
  // ignore: prefer_typing_uninitialized_variables
  var transDoc;
  // ignore: non_constant_identifier_names
  String RFID = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
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

  Future<Map<String, dynamic>> _fetchUserData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        var userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          userName = userDoc.get('userName');
          // vehiclesCode = userDoc.get('vehiclesCode');
          var vehicleDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('vehicles')
              .doc(widget.vehicleNumber)
              .get();
          if (vehicleDoc.exists) {
            RFID = vehicleDoc.get('RFID');
            transDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('vehicles')
                .doc(widget.vehicleNumber)
                .collection('prevTrans')
                .get();
            setState(() {
              _isLoading = false;
            });
          } else {
            setState(() {
              _isLoading = true;
            });
          }
          return {'userName': userName, 'RFID': RFID, 'transDoc': transDoc};
        } else {
          return {'error': 'User Not Found'};
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        return {'error': 'User Not Logged In'};
      }
    } catch (e) {
      return {'Error': '$e'};
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double? heightadjust() {
    if (transDoc.docs.length < 2) {
      return MediaQuery.of(context).size.height;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _showAppBar
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                iconSize: 34,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                widget.vehicleNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Inter',
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
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchUserData();
        },
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bgImg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Text(
                                  'TAG NO: $RFID',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Text(
                                  'Owner Name: $userName',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: heightadjust(),
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
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Previous Payments',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Center(
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/transaction.png"),
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: transDoc != null &&
                                              transDoc.docs.isNotEmpty
                                          ? transDoc.docs.length
                                          : 1,
                                      itemBuilder: (context, index) {
                                        if ((transDoc == null ||
                                            transDoc.docs.isEmpty)) {
                                          return const Padding(
                                            padding: EdgeInsets.only(
                                                top: 80,
                                                bottom: 80,
                                                right: 25,
                                                left: 40),
                                            child: Center(
                                              child: Text(
                                                'You have Not Yet started the journey!',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        var transaction = transDoc.docs[index];
                                        var amount = transaction['amount'];
                                        var fuelType = transaction['fuel-type'];
                                        var location = transaction['location'];
                                        var timestamp =
                                            (transaction['time&date']
                                                    as Timestamp)
                                                .toDate();
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: Card(
                                              elevation: 4,
                                              shadowColor: Colors.black,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Time: ${timestamp.toString()}',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF000AFF),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      'Amount: ₹$amount',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF000AFF),
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      'Fuel-Type:  $fuelType',
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFF000AFF),
                                                          fontSize: 18),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      'Pump Location:  $location',
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFF000AFF),
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
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
    );
  }
}
