import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/screens/AdminViewMode.dart';
import 'package:iluv/screens/KioskMode.dart';
import 'package:iluv/screens/KioskPlayer.dart';
import 'package:iluv/screens/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/Settings.dart';

class AppBars extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);
  final int ID;
  final String title;

  const AppBars({Key? key, required this.ID, this.title = ""})
      : super(key: key);

  @override
  State<AppBars> createState() => _AppBarsState();
}

var generalMenuItems = <String>['Settings', 'Video', 'Kiosk Mode', 'Logout','View Mode'];

Future<void> signOut(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLoggedIn", false);
  await FirebaseAuth.instance.signOut().then((value) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignIn())));
}

void selectGeneralItem(item, context) {
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
        MaterialPageRoute(builder: (context) =>  KioskPlayer(video: "OjzlfDAy1hM", playlistP: [])),
      );
      break;
    case 'Logout':
      signOut(context);
      break;
    case 'Kiosk Mode':
      // In the future, we need to change a firebase variable to only allow view access in Kiosk Mode.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KioskMode()),
      );
      break;
    case 'View Mode':
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminViewMode()));
  }
}

var creationMenuItems = <String>[
  'Delete',
];



AppBar defaultBar(String text, BuildContext context) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      PopupMenuButton<String>(onSelected: (item) {
        selectGeneralItem(item, context);
      }, itemBuilder: (BuildContext context) {
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
