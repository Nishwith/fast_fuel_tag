import 'dart:ui';

import 'package:fastfueltag/screens/home_pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
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

  final List<bool> _isOpen = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final List<Faq> faqs = [
      Faq(
        header: '1. How to recharge my wallet?',
        body:
            'The problem statement concerns the longer waiting time at fuel pumps due to the increase in the usage of credit cards and digital payments.',
      ),
      Faq(
        header: '2. How to recharge my wallet?',
        body:
            'The problem statement concerns the longer waiting time at fuel pumps due to the increase in the usage of credit cards and digital payments.',
      ),
      Faq(
        header: '3. How to recharge my wallet?',
        body:
            'The problem statement concerns the longer waiting time at fuel pumps due to the increase in the usage of credit cards and digital payments.',
      ),
      Faq(
        header: '4. How to recharge my wallet?',
        body:
            'The problem statement concerns the longer waiting time at fuel pumps due to the increase in the usage of credit cards and digital payments.',
      ),
      Faq(
        header: '5. How to recharge my wallet?',
        body:
            'The problem statement concerns the longer waiting time at fuel pumps due to the increase in the usage of credit cards and digital payments.',
      ),
    ];
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
                  'FAQs',
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
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bgImg.png"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              controller: _scrollController,
              // physics: const BouncingScrollPhysics(),
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
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 50, 10, 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(faqs.length, (index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isOpen[index] = !_isOpen[index];
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                faqs[index].header,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontFamily: 'Gothic A1',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Transform.rotate(
                                            angle: _isOpen[index]
                                                ? -3.141592653589793
                                                : 0,
                                            child: const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 30,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (_isOpen[index])
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(153, 0, 0, 0),
                                          border: Border.all(
                                              width: 3,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title: Text(
                                              faqs[index].body,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 20,
                                                fontFamily: 'Gothic A1',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  )),
            )));
  }
}

class Faq {
  final String header;
  final String body;
  Faq({required this.header, required this.body});
}
