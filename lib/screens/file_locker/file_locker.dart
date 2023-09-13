import 'dart:ui';
import 'package:fast_fuel_tag/screens/file_locker/file_upload.dart';
import 'package:fast_fuel_tag/screens/file_locker/file_view.dart';
import 'package:fast_fuel_tag/screens/home_pages/homescreen.dart';
import 'package:flutter/material.dart';

class FileLocker extends StatefulWidget {
  const FileLocker({super.key});

  @override
  State<FileLocker> createState() => _FileLockerState();
}

class _FileLockerState extends State<FileLocker> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(),
            title: const Text(
              'FILELOCKER',
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
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
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              color: Colors.white.withOpacity(0.35),
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
                              padding: EdgeInsets.fromLTRB(60, 20, 50, 50),
                              child: Image(
                                image: AssetImage("assets/images/carReg.png"),
                                height: 200,
                                fit: BoxFit.fill,
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
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  height: 70,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            'View Documents',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                              //fontFamily: 'Inter',//font to be implemented
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FileUpload()),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  height: 70,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            'Upload Documents',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              //fontFamily: 'Inter',// font to be implemented
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
                  )))),
    );
  }
}
