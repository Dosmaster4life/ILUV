import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/screens/CreateItem.dart';
import 'package:iluv/screens/KioskPlayer.dart';
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
var generalMenuItems = <String>[
  'Settings',
  'Video',
  'Create Item'
];
void selectGeneralItem(item,context) {
  switch (item) {
    case 'Settings':

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Settings()),
      );
      break;
    case 'Video':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KioskPlayer()),
      );
      break;
    case 'Create Item':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateItem()),
      );
      break;
  }
}
var creationMenuItems = <String>[
  'Delete',
];
void deleteCreationItem(item,context) {
  switch (item) {
    case 'Delete':

  }
}

AppBar defaultBar(String text, BuildContext context) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      PopupMenuButton<String>(
          onSelected:(item){
            selectGeneralItem(item, context);
          },
          itemBuilder: (BuildContext context) {
            return generalMenuItems.map((String item) {
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
AppBar CreationBar(String text, BuildContext context) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      PopupMenuButton<String>(
          onSelected:(item){
            deleteCreationItem(item, context);
          },
          itemBuilder: (BuildContext context) {
            return creationMenuItems.map((String item) {
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
    switch (widget.ID) {
      case 2:
        return settingsBar(widget.title);
        break;
      case 3:
        return CreationBar(widget.title, context);
        break;
    }
    
   return defaultBar(widget.title, context);
  }
}
