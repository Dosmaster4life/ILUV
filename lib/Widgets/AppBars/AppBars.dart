import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../screens/Settings.dart';

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
void selectItem(item,context) {
  switch (item) {
    case 'Settings':

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Settings()),
      );
      break;
    case 'Help':
      break;
  }
}
AppBar defaultBar(String text, BuildContext context) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      PopupMenuButton<String>(
          onSelected:(item){
            selectItem(item, context);
          },
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
AppBar settingsBar(String text) {
  return AppBar(
    title: Text(text),
  );
}

class _AppBarsState extends State<AppBars> {
  @override
  Widget build(BuildContext context) {
    switch (widget.ID) {
      case 2:
        return settingsBar(widget.title);
    }
   return defaultBar(widget.title, context);
  }
}
