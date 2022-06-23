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
var menuItems = <String>[
  'Settings',
  'Help',
];
void selectItem(item) {
  switch (item) {
    case 'Settings':
      break;
    case 'Help':
      break;
  }
}
AppBar defaultBar(String text) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      PopupMenuButton<String>(
          onSelected: selectItem,
          itemBuilder: (BuildContext context) {
            return menuItems.map((String item) {
              return PopupMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList();
          })
    ],
  );
}

class _AppBarsState extends State<AppBars> {
  @override
  Widget build(BuildContext context) {
   return defaultBar(widget.title);
  }
}
