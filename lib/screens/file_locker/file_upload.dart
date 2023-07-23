import 'dart:io';
import 'dart:ui';
import 'package:fast_fuel_tag/screens/file_locker/file_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({Key? key}) : super(key: key);

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  bool isLoading = false;
  PlatformFile? vehicleRC;
  PlatformFile? drivingLicense;
  PlatformFile? vehiclePollutionCertificate;
  PlatformFile? vehicleInsurance;

  Future selectFile(Function(PlatformFile?) setFile) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      setFile(result.files.first);
    });
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
    setState(() {
      isLoading = true;
    });
    final List<Future<void>> uploadFutures = [];

    uploadFutures.add(uploadFile(vehicleRC!, 'VRC'));
    uploadFutures.add(uploadFile(drivingLicense!, 'UDL'));
    uploadFutures.add(uploadFile(vehiclePollutionCertificate!, 'VPC'));
    uploadFutures.add(uploadFile(vehicleInsurance!, 'VIC'));

    await Future.wait(uploadFutures);

    const snackBar = SnackBar(
      content: Text('Files uploaded successfully.'),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      isLoading = false;
    });

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const fileView()),
    );
  }

  Future uploadFile(PlatformFile file, String fileName) async {
    final path = '00001/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);
    final fileToUpload = File(file.path!);

    await ref.putFile(fileToUpload);
  }

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const fileView()),
                    );
                  },
                ),
                title: const Text(
                  'FILELOCKER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: [
                  IconButton(
                    iconSize: 34,
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage("assets/images/reg.png"),
                            height: 130,
                            fit: BoxFit.fill,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            selectFile(
                                (file) => setState(() => vehicleRC = file));
                          },
                          child: Padding(
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
                                              color:
                                                  Color.fromARGB(168, 0, 0, 0),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            'Upload Vehicle RC',
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
                        ),
                        InkWell(
                          onTap: () {
                            selectFile((file) =>
                                setState(() => drivingLicense = file));
                          },
                          child: Padding(
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
                                              color:
                                                  Color.fromARGB(168, 0, 0, 0),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            'Upload Driving License',
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
                        ),
                        InkWell(
                          onTap: () {
                            selectFile((file) => setState(
                                () => vehiclePollutionCertificate = file));
                          },
                          child: Padding(
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
                                            'Vehicle Pollution Certificate',
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
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            'Upload Vehicle Pollution Certificate',
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
                        ),
                        InkWell(
                          onTap: () {
                            selectFile((file) =>
                                setState(() => vehicleInsurance = file));
                          },
                          child: Padding(
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
                                            'Vehicle Insurance',
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
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            'Upload Vehicle Insurance',
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
                        ),
                        InkWell(
                          onTap: () {
                            uploadFiles();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        "Upload Documents",
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
