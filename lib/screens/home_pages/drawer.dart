import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfueltag/screens/home_pages/help.dart';
import 'package:fastfueltag/screens/home_pages/homescreen.dart';
import 'package:fastfueltag/screens/user_verification/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white.withOpacity(1),
      child: FutureBuilder(
        future: _fetchUserName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String userName = snapshot.data.toString();
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.purple, Colors.blue])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/avatar.png'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Add New Vehicle'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(key: UniqueKey(), initialIndex: 0),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Help & Requests'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Help()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('FAQs'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Help()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('About Us'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Help()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('LogOut'),
                    onTap: () async {
                      try {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('email');
                        prefs.remove('password');
                        await FirebaseAuth.instance.signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signin()));
                      } catch (e) {
                        return;
                      }
                    },
                  ),
                ],
              );
            }
          }
        },
      ),
    );
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
