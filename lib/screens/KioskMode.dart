import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/Widgets/CreationForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/AppBars/AppBars.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class KioskMode extends StatefulWidget {
  const KioskMode({Key? key}) : super(key: key);

  @override
  State<KioskMode> createState() => _KioskModeState();
}

class _KioskModeState extends State<KioskMode> {
  StreamBuilder<QuerySnapshot> buildStreamBuilder() {
    String user = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(user)
            .where("URL", isNull: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return SafeArea(child: Scaffold(body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(children: <Widget>[
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 3,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      children: snapshot.data!.docs.map((document) {
                        String finalVideoURL = "";
                        try {
                          var videoURL = document["URL"] ?? "";

                          finalVideoURL =
                              YoutubePlayerController.convertUrlToId(
                                      videoURL) ??
                                  "";
                        } catch (e) {}
                        try {
                          String url = YoutubePlayerController.getThumbnail(
                              videoId: finalVideoURL,
                              webp: false,
                              quality: ThumbnailQuality.max);
                          double height = MediaQuery.of(context).size.height;
                          double width = MediaQuery.of(context).size.width;
                          String description = document["Description"] ?? "";
                          String title = document["Title"] ?? "";

                          return Card(
                              child: Column(children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        fontFamily: 'Montserrat'))),
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    .doc("Admin")
                                    .set({
                                  "Video": document["URL"],
                                });
                              },
                              child: Stack(children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.play_arrow)),
                                Ink.image(
                                  image: NetworkImage(url),
                                  fit: BoxFit.contain,
                                ),
                              ]),
                            )),
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(description,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Montserrat',
                                    ))),
                          ]));
                        } catch (e) {
                          return Container();
                        }
                      }).toList()))
            ]);
          })));
        });
  }

  Future<void> lockMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isKiosk", true);
  }

  Widget build(BuildContext context) {
    lockMode();
    return Scaffold(
      body: buildStreamBuilder(),
      appBar: AppBars(ID: 4, title: "Videos"),
    );
  }
}
