import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_fuel_tag/screens/home_pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class RegistrationPay extends StatefulWidget {
  const RegistrationPay(
      {Key? key,
      required this.vehicleNumber,
      required this.uid,
      required this.vrc,
      required this.udl,
      required this.vic,
      required this.vpc,
      required this.selectedVehicleType})
      : super(key: key);
  final String vehicleNumber;
  final String uid;
  final String vrc;
  final String udl;
  final String vic;
  final String vpc;
  final String selectedVehicleType;

  @override
  State<RegistrationPay> createState() => _RegistrationPayState();
}

class _RegistrationPayState extends State<RegistrationPay> {
  bool isLoading = false;
  bool _showAppBar = true;
  late String vehicleNumber;
  late String vrc;
  late String udl;
  late String vic;
  late String vpc;
  late String uid;
  late String typeCode;
  late String selectedVehicleType;

  final ScrollController _scrollController = ScrollController();
  void _updatePaymentStatus(BuildContext context, String vehicleNumber,
      String uid, String selectedVehicleType) async {
    try {
      setState(() {
        isLoading = true;
      });

      DocumentReference oldVehicleDoc = FirebaseFirestore.instance
          .collection('registeredVehicles')
          .doc('$vehicleNumber-Pending/$uid/$vehicleNumber');
      DocumentReference newVehicleDoc = FirebaseFirestore.instance
          .collection('registeredVehicles')
          .doc("$vehicleNumber-Paid/$uid/$vehicleNumber");
      DocumentSnapshot oldVehicleSnapshot = await oldVehicleDoc.get();
      Map<String, dynamic> vehicleData =
          oldVehicleSnapshot.data() as Map<String, dynamic>;
      vehicleData['paymentStatus'] = 'Paid';
      await newVehicleDoc.set(vehicleData);
      await oldVehicleDoc.delete();
      if (selectedVehicleType == 'Two Wheeler') {
        typeCode = "2";
      } else if (selectedVehicleType == 'Geared Two Wheeler') {
        typeCode = "2g";
      } else if (selectedVehicleType == 'Four Wheeler') {
        typeCode = "4";
      } else {
        typeCode = "2g";
      }
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('vehicles')
          .doc(vehicleNumber)
          .set({
        'vehicleNum': vehicleNumber,
        'vehicleType': selectedVehicleType,
        'typeCode': typeCode,
        'RFID': 'In-process',
        'VRC': vrc,
        'VIC': vic,
        'VPC': vpc,
        'UDL': udl,
      });
      const snackBar = SnackBar(
        content: Text('Payment successful. Payment status updated.'),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen(
                  initialIndex: 1,
                )),
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('An error occurred while updating payment status.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    vehicleNumber = widget.vehicleNumber;
    uid = widget.uid;
    vrc = widget.vrc;
    vic = widget.vic;
    vpc = widget.vpc;
    udl = widget.udl;
    selectedVehicleType = widget.selectedVehicleType;
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
                  'REGISTRATION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
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
                            const Padding(
                              padding: EdgeInsets.only(top: 35),
                              child: SizedBox(
                                child: Text(
                                  'Hey User! Register your vehicle.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Image(
                                image: AssetImage("assets/images/pay.png"),
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(9.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Amount',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '500',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _updatePaymentStatus(context, vehicleNumber,
                                    uid, selectedVehicleType);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 20),
                                    child: isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(
                                            "Pay",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            )
                          ],
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
