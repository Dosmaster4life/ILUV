import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/main.dart';
import 'package:iluv/screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignIn.dart';

class loginChecker extends StatefulWidget {
  const loginChecker({Key? key}) : super(key: key);

  @override
  State<loginChecker> createState() => _loginCheckerState();
}

class _loginCheckerState extends State<loginChecker> {

  int currentPage = 0;
  Future<void> checkSignedIn() async {

    if (FirebaseAuth.instance.currentUser != null || loggedIn!) {
      // check if user is in kiosk mode next through firebase
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
    checkSignedIn();
    return MaterialApp(home: screensToReturn.elementAt(currentPage));
  }
}
