import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TranactionPage extends StatefulWidget {
  const TranactionPage({Key? key, required this.vehicleNumber})
      : super(key: key);
  final String vehicleNumber;
  @override
  State<TranactionPage> createState() => _TranactionPageState();
}

class _TranactionPageState extends State<TranactionPage> {
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
              title: Text(
                widget.vehicleNumber,
                style: const TextStyle(
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
        width: MediaQuery.of(context).size.width,
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
            padding: const EdgeInsets.only(top: 90),
            child: Column(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Text(
                          'TAG NO:00XXX01',
                          textAlign: TextAlign.left,
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
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Text(
                          'Owner Name: User Name',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
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
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Previous Payments',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 150,
                              width: 150,
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/transaction.png"),
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(width: 1.0),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Card(
                                      elevation: 4,
                                      shadowColor: Colors.black,
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'TIME: 2023-07-03 22:30:30.005',
                                              style: TextStyle(
                                                color: Color(0xFF000AFF),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'AMOUNT: 200',
                                              style: TextStyle(
                                                color: Color(0xFF000AFF),
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'FUEL: 1.5 liters',
                                              style: TextStyle(
                                                  color: Color(0xFF000AFF),
                                                  fontSize: 18),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Pump Name: Bharat Petrol Pump, Miyapur',
                                              style: TextStyle(
                                                  color: Color(0xFF000AFF),
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
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
      ),
    );
  }
}
