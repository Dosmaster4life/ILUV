import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iluv/main.dart';
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
    if (FirebaseAuth.instance.currentUser != null || loggedIn) {
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
    return MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: themeBrightness,
          primaryColor: Color.fromARGB(255, 0, 255, 229),

          // Define the default font family.
          fontFamily: 'Montserrat',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
          ),
        ),
        home: screensToReturn.elementAt(currentPage));
  }
}
