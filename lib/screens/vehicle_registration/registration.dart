import 'dart:ui';
import 'package:fast_fuel_tag/screens/home_pages/vehicles_page.dart';
import 'package:fast_fuel_tag/screens/vehicle_registration/registration_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // ignore: prefer_typing_uninitialized_variables
  var selectedVehicleType;
  final List<String> _vehicle = <String>[
    'Two Wheeler',
    'Geared Two Wheeler',
    'Four Wheeler',
    'Heavy Vehicle',
  ];
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
    return Scaffold(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const YourVehicles()),
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
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 140),
              child: ClipRect(
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
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage("assets/images/reg.png"),
                            height: 130,
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
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      'Vehicle Number',
                                      style: TextStyle(
                                        color: Color.fromARGB(168, 0, 0, 0),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w200,
                                      ),
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your Vehicle Number',
                                      )),
                                ],
                              ),
                            ),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      'Vehicle Type',
                                      style: TextStyle(
                                        color: Color.fromARGB(168, 0, 0, 0),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: DropdownButtonFormField<String>(
                                        items: _vehicle
                                            .map(
                                              (value) => DropdownMenuItem(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 14,
                                                      fontFamily: 'montserrat'),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        // ignore: non_constant_identifier_names
                                        onChanged: (SelectedCity) {
                                          setState(() {
                                            selectedVehicleType = SelectedCity;
                                          });
                                        },
                                        isExpanded: true,
                                        value: selectedVehicleType,
                                        decoration: const InputDecoration(
                                            hintText:
                                                'Select your Vehicle Type',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'montserrat')),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select a city';
                                          }
                                          return null;
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 65,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          'Vehicle RC',
                                          style: TextStyle(
                                            color: Color.fromARGB(168, 0, 0, 0),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          'Upload your Vehicle RC',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.cloud_upload,
                                    size: 40,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 65,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          'Driving License',
                                          style: TextStyle(
                                            color: Color.fromARGB(168, 0, 0, 0),
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          'Upload your Driving License',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.cloud_upload,
                                    size: 40,
                                  )
                                ],
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
                                      const RegistrationPay()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Text(
                                  "Register",
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
            ),
          ),
        ));
  }
}
