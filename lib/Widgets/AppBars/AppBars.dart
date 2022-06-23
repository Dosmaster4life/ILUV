import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBars extends StatefulWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(50);
  final int ID;
  final String title;
  const AppBars({Key? key, required this.ID, this.title = ""}) : super(key: key);

  @override
  State<AppBars> createState() => _AppBarsState();
}

AppBar defaultBar(String text) {
  return AppBar(
    title: Text(text),
  );
}

class _AppBarsState extends State<AppBars> {
  @override
  Widget build(BuildContext context) {
  /* switch (widget.ID) {
     case 1: {

     }
   }*/
   return defaultBar(widget.title);
  }
}
