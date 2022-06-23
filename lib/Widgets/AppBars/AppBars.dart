import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBars extends StatefulWidget {
  const AppBars({Key? key}) : super(key: key);

  @override
  State<AppBars> createState() => _AppBarsState();
}



class _AppBarsState extends State<AppBars> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Default"),
    );
  }
}
