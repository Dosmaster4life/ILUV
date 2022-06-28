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
                      videoId: finalVideoURL, webp: false);
                  return Card(
                      child: ListTile(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreationForm(
                                      documentExistString: document.id ?? "")),
                            );
                          },
                          title: Text(document["Title"]),
                          leading: Image(image: NetworkImage(url)),
                          trailing: IconButton(
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
                          )));
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
