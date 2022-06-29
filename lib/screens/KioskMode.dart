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
import 'package:flip_card/flip_card.dart';

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
                  String description = document["Description"] ?? "";
                  String title = document["Title"] ?? "";

                  return Card(
                      elevation: 4.0,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(title, textAlign: TextAlign.center),
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  .doc("Admin")
                                  .set({
                                "Video": document["URL"],
                              }).then((value) {});
                            },
                            icon: Container(
                              height: height / 3,
                              child: Ink.image(
                                image: NetworkImage(url),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16.0),
                            child:
                                Text(description, textAlign: TextAlign.center),
                          ),
                        ],
                      ));
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
