import 'dart:ui';
import 'package:fast_fuel_tag/screens/fileView.dart';
import 'package:flutter/material.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            iconSize: 34,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          title: const Text(
            'DIGILOCKER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontFamily: 'Inter',
              //we need to add fonts
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
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bgImg.png"),
                  fit: BoxFit.cover)),
          child: Expanded(
            child: SingleChildScrollView(
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
                            .withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: Colors.white.withOpacity(0.25),
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const fileView()),
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
          ),
        ));
  }
}
