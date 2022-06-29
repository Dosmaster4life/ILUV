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

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlipCard(
                        direction: FlipDirection.VERTICAL,
                        back: Card(
                            shadowColor: Colors.transparent,
                            child: ListTile(
                                minVerticalPadding: height / 5,
                                leading: Text(description,
                                    textAlign: TextAlign.center))),
                        front: Card(
                            shadowColor: Colors.transparent,
                            child: Expanded(
                              child: ListTile(
                                  minVerticalPadding: height / 5,
                                  //title: Text(document["Title"]),
                                  trailing: GestureDetector(
                                      onTap: () {},
                                      child: SizedBox(
                                        height: double.infinity,
                                        child: Expanded(
                                          child: Image(
                                              fit: BoxFit.fitHeight,
                                              image: NetworkImage(url)),
                                        ),
                                      )),
                                  leading: IconButton(
                                    icon: Icon(Icons.play_arrow),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => KioskPlayer(
                                                  video: document["URL"],
                                                  playlistP: [],
                                                )),
                                      );
                                    },
                                  )),
                            )),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const CreationForm(documentExistString: "")),
          );
        },
      ),
      appBar: AppBars(ID: 0, title: "Video List"),
    );
  }
}
