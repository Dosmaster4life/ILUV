import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/Widgets/CreationForm.dart';
import '../Widgets/AppBars/AppBars.dart';
import 'KioskPlayer.dart';
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
        stream: FirebaseFirestore.instance.collection(user).snapshots(),
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
                  child: ListView(
                      children: snapshot.data!.docs.map((document) {
                String finalVideoURL = "";
                try {
                  var videoURL = document["URL"] ?? "";

                  finalVideoURL =
                      YoutubePlayerController.convertUrlToId(videoURL) ?? "";
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

                  return SafeArea(
                    child: Card(
                        elevation: 4.0,
                        child: Row(children: [
                          Column(children: [
                            SizedBox(
                                height: height / 6,
                                width: width / 2.5,
                                child: Expanded(
                                    child: Text(title,
                                        textAlign: TextAlign.center))),
                            SizedBox(
                              height: height / 3,
                              width: width / 2.5,
                              child: Text(description,
                                  textAlign: TextAlign.center),
                            )
                          ]),
                          Column(children: [
                            Container(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  height: height / 2,
                                  width: width / 2,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .doc("Admin")
                                          .set({
                                        "Video": document["URL"],
                                      }).then((value) {});
                                    },
                                    child: Ink.image(
                                      image: NetworkImage(url),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )),
                          ])
                        ])),
                  );
                } catch (e) {
                  return Container();
                }
              }).toList()))
            ]);
          })));
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: buildStreamBuilder(),
      appBar: AppBars(ID: 0, title: "Videos"),
    );
  }
}
