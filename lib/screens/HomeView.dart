import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/Widgets/CreationForm.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../Widgets/AppBars/AppBars.dart';
import 'KioskPlayer.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  Future<void> firstRun() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc("Admin")
        .get();

    if (docSnapshot.exists) {
    } else {
      FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc("Admin")
          .set({
        "Video": "",
      }).then((value) {});
    }
  }

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

          return ListView(
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
                        title: new Text(document["Title"]),
                        leading: Image(image: NetworkImage(url)),
                        trailing: IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            String d = YoutubePlayerController.convertUrlToId(
                                    document["URL"]) ??
                                "";
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KioskPlayer(
                                        video: document["URL"],
                                        playlistP: [d],
                                      )),
                            );
                          },
                        )));
              } catch (e) {
                return Container();
              }
            }).toList(),
          );
        });
  }

  Widget build(BuildContext context) {
    firstRun();

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
