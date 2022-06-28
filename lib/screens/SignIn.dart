import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'SignUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String loginEmail, Password, errorMessage = "";
  final authenticate = FirebaseAuth.instance;

  @override
  Scaffold settingsList() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("ILuv Login"),
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
                    // onSubmitted: (value) {
                    //   debugPrint("Value is" + value);
                    //   LoginAction();
                    // },
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
                    onEditingComplete: () {
                      LoginAction();
                    },
                    onChanged: (value) {
                      setState(() {
                        Password = value.trim();
                      });
                    }),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * .85,
                  height: MediaQuery.of(context).size.height * .1,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: const Text(
                        "         Login         ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        await LoginAction();
                      }),
                ),
              ]),
              ListTile(
                  title: const Center(
                      child: Text("Forgot Password?",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14))),
                  onTap: () => {
                        if (loginEmail.isNotEmpty &&
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(loginEmail))
                          {
                            setState(() {
                              passwordReset(loginEmail);
                            }),
                            errorMessage =
                                "If your account exist, a reset link will be sent to you.",
                          }
                        else
                          {
                            setState(() {
                              errorMessage = "Please enter your email address";
                            }),
                          }
                      }),
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
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) => const SignUp()));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: const Text("        Create Account        ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ))),
            ],
          ))
        ]));
  }

  Future<void> LoginAction() async {
    debugPrint("DEBUG: Logged in my dude!");
    if (loginEmail == null) {
    } else {
      try {
        UserCredential login = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: loginEmail, password: Password);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = 'Incorrect Credentials';
        });
      }
    }
  }

  Future<void> passwordReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return settingsList();
  }
}
