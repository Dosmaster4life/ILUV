import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KioskMode extends StatefulWidget {
  const KioskMode({Key? key}) : super(key: key);

  @override
  State<KioskMode> createState() => _KioskModeState();
}

class _KioskModeState extends State<KioskMode> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Text("Kiosk Mode"),
    );
  }
}
