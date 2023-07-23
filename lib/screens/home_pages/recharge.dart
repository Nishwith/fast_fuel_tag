import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class Recharge extends StatefulWidget {
  const Recharge({Key? key}) : super(key: key);

  @override
  State<Recharge> createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
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
                'RECHARGE',
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
              image: AssetImage("assets/images/bgImg.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          // controller: _scrollController,
          // physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 25),
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
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SizedBox(
                    child: Text(
                      'Balance:500',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
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
                                'Hey User! Recharge your wallet.',
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                                      padding: EdgeInsets.all(3.0),
                                      child: Text(
                                        'Amount',
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
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText:
                                              'Enter the recharge amount'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all((Radius.circular(15))),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                                child: Text(
                                  'Pay',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800),
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
    );
  }
}
