import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfueltag/screens/home_pages/drawer.dart';
import 'package:fastfueltag/screens/home_pages/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final TextEditingController _queryController = TextEditingController();
  bool _showAppBar = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
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
                'HELP',
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
      body: FutureBuilder(
          future: _fetchUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                String userName = snapshot.data.toString();
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.jpeg"),
                        fit: BoxFit.cover),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(50),
                            child: SizedBox(
                              child: Text(
                                'Owner Name : $userName',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                decoration: ShapeDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)
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
                                      padding: EdgeInsets.only(top: 45),
                                      child: SizedBox(
                                        child: Text(
                                          'Hey User! Reach Us !',
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
                                      padding: EdgeInsets.all(30),
                                      child: SizedBox(
                                        child: Text(
                                          'Brief your problem',
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
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(3.0),
                                                child: Text(
                                                  'Help',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        168, 0, 0, 0),
                                                    fontSize: 14,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              TextField(
                                                controller: _queryController,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w200,
                                                ),
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        'Write your problem in brief'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          _onRaisedTicketPressed(
                                              _queryController.text);
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                (Radius.circular(15))),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                25, 25, 25, 25),
                                            child: Text(
                                              'Raise ticket',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w800),
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
                );
              }
            }
          }),
    );
  }

  Future<void> _onRaisedTicketPressed(String query) async {
    if (query.trim().isEmpty) {
      // If the TextField is empty, show a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill your queries.'),
      ));
    } else {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        User? user = auth.currentUser;
        if (user != null) {
          String uid = user.uid;
          CollectionReference queriesCollection =
              FirebaseFirestore.instance.collection('Queries');
         DocumentReference userDocRef = queriesCollection.doc();

        await userDocRef.set({
          'query': query,
          'timestamp': FieldValue.serverTimestamp(),
          'uid': uid,
        });


          // Display a success message to the user
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Query submitted successfully!'),
          ));
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        initialIndex: 1,
                        key: UniqueKey(),
                      )));
        } else {
          // Handle the case where the user is not logged in
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('User not logged in.'),
          ));
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
        ));
      }
    }
  }

  Future<String> _fetchUserName() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        var userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          String userName = userDoc.get('userName');
          return userName;
        } else {
          return 'User Not Found';
        }
      } else {
        return 'User Not Logged In';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
