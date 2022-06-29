import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/Widgets/AppBars/AppBars.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    const IconData mode_night_outlined =
        IconData(0xf1d9, fontFamily: 'MaterialIcons');
    return const Scaffold(
      appBar: AppBars(
        ID: 2,
        title: "Settings",
      ),
      // body: SafeArea(
      //     child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      //   Expanded(
      //       child: Column(children: [
      //     Padding(
      //         padding: EdgeInsets.all(20.0),
      //         child: ElevatedButton.icon(
      //           onPressed: () => {
      //             method name to toggle night mode,
      //             if (themeBrightness == Brightness.dark) {
      //               themeBrightness = Brightness.light;
      //             }
      //             else {
      //               themeBrightness = Brightness.dark;
      //             }
      //             debugPrint("DEBUG: TOGGLE NIGHT MODE!!")
      //           },
      //           icon: Icon(Icons.mode_night_outlined),
      //           label: Text(
      //             'Night Mode Toggle',
      //             style: GoogleFonts.montserrat(),
      //           ),
      //         ))
      //   ]))
      // ]))
    );
  }
}
