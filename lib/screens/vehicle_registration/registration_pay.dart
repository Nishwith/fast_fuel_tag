import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_fuel_tag/screens/home_pages/vehicles_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class RegistrationPay extends StatefulWidget {
  const RegistrationPay({Key? key, required this.vehicleNumber})
      : super(key: key);
  final String vehicleNumber;

  @override
  State<RegistrationPay> createState() => _RegistrationPayState();
}

class _RegistrationPayState extends State<RegistrationPay> {
  bool isLoading = false;
  bool _showAppBar = true;
  String vehicleNumber = '';
  final ScrollController _scrollController = ScrollController();
  void _updatePaymentStatus(BuildContext context, String vehicleNumber) async {
    try {
      setState(() {
        isLoading = true;
      });
      DocumentReference oldVehicleDoc = FirebaseFirestore.instance
          .collection('vehicles')
          .doc('$vehicleNumber-Pending');
      DocumentReference newVehicleDoc = FirebaseFirestore.instance
          .collection('vehicles')
          .doc('$vehicleNumber-paid');
      DocumentSnapshot oldVehicleSnapshot = await oldVehicleDoc.get();
      Map<String, dynamic> vehicleData =
          oldVehicleSnapshot.data() as Map<String, dynamic>;
      vehicleData['paymentStatus'] = 'Paid';
      await newVehicleDoc.set(vehicleData);
      await oldVehicleDoc.delete();

      const snackBar = SnackBar(
        content: Text('Payment successful. Payment status updated.'),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const YourVehicles()),
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error updating payment status: $e');
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
                leading: IconButton(
                  iconSize: 34,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text(
                  'REGISTRATION',
                  style: TextStyle(
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
                      //navigate to some other page
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
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: SizedBox(
                      child: Text(
                        'Owner Name :User Name',
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

                  // padding: const EdgeInsets.only(top: 70),
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
                                _updatePaymentStatus(context, vehicleNumber);
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
