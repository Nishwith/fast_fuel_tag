import 'dart:ui';
import 'package:fast_fuel_tag/screens/home_pages/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore: camel_case_types
class fileView extends StatefulWidget {
  const fileView({super.key, required this.vehicleNumber});
  final String vehicleNumber;
  @override
  State<fileView> createState() => _fileViewState();
}

// ignore: camel_case_types
class _fileViewState extends State<fileView> {
  String? uid;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    } else {}
  }

  bool isLoading = false;
  Future<String?> getFileUrl(String fileName) async {
    // final extension = getExtension(fileName);
    final ref = FirebaseStorage.instance
        .ref()
        .child('RegisteredVehicles/${widget.vehicleNumber}/$uid/$fileName');
    return await ref.getDownloadURL();
  }

  Future<String?> getExtension(String fileName) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('RegisteredVehicles/${widget.vehicleNumber}/$uid/$fileName');
    final metadata = await ref.getMetadata();
    final contentType = metadata.contentType;
    String? extension;
    if (contentType == 'image/jpeg' || contentType == 'image/png') {
      extension = 'jpg';
    } else if (contentType == 'application/pdf') {
      extension = 'pdf';
    }
    return extension;
  }

  void viewFile(String fileName) async {
    setState(() {
      isLoading = true;
    });
    final fileUrl = await getFileUrl(fileName);
    final extension = await getExtension(fileName);
    if (fileUrl != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ImageViewScreen(fileUrl: fileUrl, extension: extension),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } else {}
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
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
                  _scaffoldKey.currentState?.openDrawer();
                })
          ],
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
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
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Column(
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
                                  onTap: () => viewFile('VRC'),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height: 65,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
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
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'Vehicle RC',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          168, 0, 0, 0),
                                                      fontSize: 15,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'View Vehicle RC',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.search,
                                              size: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => viewFile('UDL'),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height: 65,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
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
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'Driving License',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          168, 0, 0, 0),
                                                      fontSize: 15,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'View Driving License',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.search,
                                              size: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => viewFile('VPC'),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height: 65,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
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
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'Vehicle Pollution Certificate',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          168, 0, 0, 0),
                                                      fontSize: 15,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'View Vehicle Pollution Certificate',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.search,
                                              size: 40,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => viewFile('VIC'),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      height: 65,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
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
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'Vehicle Insurance',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          168, 0, 0, 0),
                                                      fontSize: 15,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'View Vehicle Insurance',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(
                                              Icons.search,
                                              size: 40,
                                            )
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
                ))));
  }
}

class ImageViewScreen extends StatefulWidget {
  final String fileUrl;
  final String? extension;

  const ImageViewScreen(
      {super.key, required this.fileUrl, required this.extension});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  double? _progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 20, 2, 20),
              child: widget.extension == 'jpg'
                  ? InteractiveViewer(
                      minScale: 1,
                      maxScale: 5.0,
                      child: Image.network(
                        widget.fileUrl,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                  color: Colors.purple,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  : SfPdfViewer.network(
                      widget.fileUrl,
                      canShowPageLoadingIndicator: true,
                    ))),
      floatingActionButton: _progress != null
          ? const CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: () {
                FileDownloader.downloadFile(
                  url: widget.fileUrl,
                  name: nameCreate(),
                  onProgress: (name, progress) {
                    setState(() {
                      _progress = progress;
                    });
                  },
                  onDownloadCompleted: (value) {
                    setState(() {
                      _progress = null;
                    });
                  },
                );
              },
              tooltip: 'Download',
              child: const Icon(Icons.file_download),
            ),
    );
  }

  String nameCreate() {
    String name = 'certificate.${widget.extension}';
    return name;
  }
}
