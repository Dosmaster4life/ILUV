import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/screens/Home.dart';

import 'SignIn.dart';

class loginChecker extends StatefulWidget {
  const loginChecker({Key? key}) : super(key: key);

  @override
  State<loginChecker> createState() => _loginCheckerState();
}

class _loginCheckerState extends State<loginChecker> {
  int currentPage = 0;

  Future<void> checkSignedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      currentPage = 1;
      setState(() {});
    }
  }

  List<Widget> screensToReturn = <Widget>[
    // Current Home Screens
    const SignIn(),
    const Home(),
  ];

  Widget build(BuildContext context) {
    return MaterialApp(home: screensToReturn.elementAt(currentPage));
  }
}
