import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/screens/HomeView.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

int currentPage = 0;

List<Widget> listOfScreen = <Widget>[
  // const NavigationBottomBar(hideB: false),
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Screen1());
  }
}
