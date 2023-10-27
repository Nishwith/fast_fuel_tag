import 'dart:io';
import 'dart:ui';
import 'package:fastfueltag/screens/home_pages/drawer.dart';
import 'package:fastfueltag/screens/home_pages/homescreen.dart';
import 'package:fastfueltag/screens/vehicle_registration/registration_pay.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mime/mime.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // ignore: prefer_typing_uninitialized_variables
  var selectedVehicleType;
  late String uid;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    } else {}
  }

  bool isLoading = false;
  final List<String> _vehicle = <String>[
    'Two Wheeler',
    'Geared Two Wheeler',
    'Four Wheeler',
  ];
  TextEditingController vehicleNumberController = TextEditingController();
  String vehicleNumber = '';
  PlatformFile? vehicleRC;
  PlatformFile? vehicleInsurance;
  PlatformFile? vehiclePollutionCertificate;
  PlatformFile? drivingLicense;
  bool _showAppBar = true;
  final ScrollController _scrollController = ScrollController();

  Future selectFile(Function(PlatformFile?) setFile) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result == null) return;

    final selectedFile = result.files.first;
    final allowedTypes = ['pdf', 'jpg', 'jpeg', 'png'];
    final fileType = selectedFile.extension?.toLowerCase();

    if (fileType != null && allowedTypes.contains(fileType)) {
      setState(() {
        setFile(selectedFile);
      });
    } else {
      const snackBar = SnackBar(
        content: Text('Please select an image or PDF file.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool allFilesSelected() {
    return vehicleRC != null &&
        drivingLicense != null &&
        vehiclePollutionCertificate != null &&
        vehicleInsurance != null;
  }

  Future uploadFiles() async {
    if (!allFilesSelected()) {
      const snackBar = SnackBar(
        content: Text('Please select all required documents.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    final List<PlatformFile> files = [
      vehicleRC!,
      drivingLicense!,
      vehicleInsurance!,
      vehiclePollutionCertificate!
    ];
    final List<Future<void>> uploadFutures = [];
    for (var file in files) {
      String fileName = "";
      uploadFutures.add(uploadFile(file, fileName));
    }

    await Future.wait(uploadFutures);

    const snackBar = SnackBar(
      content: Text('Files uploaded successfully.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final RegExp _pattern = RegExp(r'^[A-Za-z]{2}\d{2}[A-Za-z]{2}\d{4}$');
  bool isValidVehicleNumber(String input) {
    return _pattern.hasMatch(input);
  }

  Future<String?> uploadFile(PlatformFile file, String fileName) async {
    String? filePath;

    try {
      filePath =
          'RegisteredVehicles/$vehicleNumber/$uid/$fileName'; // Include the extension in the file path
      final ref = FirebaseStorage.instance.ref().child(filePath);
      final fileToUpload = File(file.path!);

      String? mimeType = lookupMimeType(file.path!);

      await ref.putFile(
        fileToUpload,
        SettableMetadata(contentType: mimeType),
      );

      // Get the download URL of the uploaded file
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    vehicleNumberController.dispose();
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

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() || !allFilesSelected()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill the required details.')),
      );
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        CollectionReference vehiclesCollection =
            FirebaseFirestore.instance.collection('registeredVehicles');
        DocumentReference newVehicleDoc = vehiclesCollection
            .doc('$vehicleNumber-Pending')
            .collection(uid)
            .doc(vehicleNumber);
        String? vicUrl = await uploadFile(vehicleInsurance!, 'VIC');
        String? vpcUrl = await uploadFile(vehiclePollutionCertificate!, 'VPC');
        String? vrcUrl = await uploadFile(vehicleRC!, 'VRC');
        String? udlUrl = await uploadFile(drivingLicense!, 'UDL');

        Map<String, dynamic> vehicleData = {
          'vehicleNumber': vehicleNumber,
          'vehicleType': selectedVehicleType,
          'VRC': vrcUrl,
          'UDL': udlUrl,
          'VIC': vicUrl,
          'VPC': vpcUrl,
          'paymentStatus': 'Pending',
        };
        await newVehicleDoc.set(vehicleData);

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegistrationPay(
                    vehicleNumber: vehicleNumber,
                    uid: uid,
                    selectedVehicleType: selectedVehicleType,
                    udl: udlUrl!,
                    vic: vicUrl!,
                    vpc: vpcUrl!,
                    vrc: vrcUrl!,
                  )),
        );

        setState(() {
          vehicleRC = null;
          vehicleInsurance = null;
          vehiclePollutionCertificate = null;
          drivingLicense = null;
          isLoading = false;
        });
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred. Please try again later.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      initialIndex: 1,
                      key: UniqueKey(),
                    )));
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
          body: Form(
              key: _formKey,
              child: Container(
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
                          height: MediaQuery.of(context).size.height * 1.3,
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            'Vehicle Number',
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                  168, 0, 0, 0),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  28,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: vehicleNumberController,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w200,
                                          ),
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Enter your Vehicle Number',
                                              hintStyle: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          28,
                                                  fontFamily: 'montserrat')),
                                          onChanged: (value) {
                                            setState(() {
                                              vehicleNumber =
                                                  value.toUpperCase();
                                            });
                                          },
                                          // ignore: body_might_complete_normally_nullable
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Vehicle number is required';
                                            }
                                            if (!isValidVehicleNumber(
                                                vehicleNumber)) {
                                              return 'Invalid vehicle number';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            'Vehicle Type',
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(168, 0, 0, 0),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child:
                                                DropdownButtonFormField<String>(
                                              items: _vehicle
                                                  .map(
                                                    (value) => DropdownMenuItem(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'montserrat'),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              // ignore: non_constant_identifier_names
                                              onChanged: (SelectedCity) {
                                                setState(() {
                                                  selectedVehicleType =
                                                      SelectedCity;
                                                });
                                              },
                                              isExpanded: true,
                                              value: selectedVehicleType,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Select your Vehicle Type',
                                                  hintStyle: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              28,
                                                      fontFamily:
                                                          'montserrat')),
                                              // ignore: body_might_complete_normally_nullable
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Please select a city';
                                                }
                                              },
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  selectFile((file) =>
                                      setState(() => vehicleRC = file));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: 65,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Text(
                                                  'Vehicle RC',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        168, 0, 0, 0),
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: vehicleRC != null
                                                      ? const Text(
                                                          'Selected',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 15,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        )
                                                      : Text(
                                                          'Upload Vehicle RC',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                28,
                                                            fontFamily:
                                                                'montserrat',
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        )),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.cloud_upload,
                                            size: 40,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  selectFile((file) =>
                                      setState(() => drivingLicense = file));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: 65,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  'Driving License',
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        168, 0, 0, 0),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            28,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: drivingLicense != null
                                                      ? const Text(
                                                          'Selected',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 15,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        )
                                                      : Text(
                                                          'Upload Driving License',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                28,
                                                            fontFamily:
                                                                'montserrat',
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        )),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.cloud_upload,
                                            size: 40,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  selectFile((file) =>
                                      setState(() => vehicleInsurance = file));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: 65,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  'Vehicle Insurance Certificate',
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        168, 0, 0, 0),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            28,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: vehicleInsurance !=
                                                          null
                                                      ? const Text(
                                                          'Selected',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 15,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        )
                                                      : Text(
                                                          'Upload Vehicle Insurance Certificate',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                28,
                                                            fontFamily:
                                                                'montserrat',
                                                            fontWeight:
                                                                FontWeight.w200,
                                                          ),
                                                        )),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.cloud_upload,
                                            size: 40,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  selectFile((file) => setState(() =>
                                      vehiclePollutionCertificate = file));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: 65,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  'Vehicle Pollution Certificate',
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        168, 0, 0, 0),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            28,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child:
                                                      vehiclePollutionCertificate !=
                                                              null
                                                          ? const Text(
                                                              'Selected',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .purple,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                              ),
                                                            )
                                                          : Text(
                                                              'Upload Vehicle Pollution Certificate',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    28,
                                                                fontFamily:
                                                                    'montserrat',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                              ),
                                                            )),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.cloud_upload,
                                            size: 40,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _submitForm();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
              ))),
    );
  }
}
