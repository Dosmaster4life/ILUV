import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Home.dart';
import 'SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String loginEmail, Password, errorMessage = "";
  final authenticate = FirebaseAuth.instance;

  @override
  Scaffold settingsList() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Create ILuv Account'),
        ),
        body: Stack(children: <Widget>[
          Column(
            children: [
              Text(errorMessage),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "Email"),
                    onChanged: (value) {
                      setState(() {
                        loginEmail = value.trim();
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Password"),
                    onChanged: (value) {
                      setState(() {
                        Password = value.trim();
                      });
                    }),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ButtonTheme(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        "         Create         ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        try {
                          UserCredential login = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: loginEmail,
                            password: Password,
                          );
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool("isLoggedIn", true);
                          prefs.setBool("isKiosk", true);
                          kioskMode =  false;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            errorMessage = e.code;
                          });
                        }
                      }),
                ),
              ]),
            ],
          ),
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Text(
                "OR",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn(kioskLoader: false,)));
                  },
                  child: const Text("    Return to Sign In    ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ))),
            ],
          ))
        ]));
  }

  Widget build(BuildContext context) {
    return settingsList();
  }
}
