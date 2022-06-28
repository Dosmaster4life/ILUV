import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class KioskPlayer extends StatefulWidget {
  final String video;
   KioskPlayer({Key? key, required this.video}) : super(key: key);

  @override
  State<KioskPlayer> createState() => _KioskPlayerState();
}



class _KioskPlayerState extends State<KioskPlayer> {
  @override
  bool checkUpdater = true;
  late YoutubePlayerController _controller;
  String currentVideo = "";
  Widget build(BuildContext context) {

    String videoURL = widget.video ?? "";
    String? finalVideoURL = YoutubePlayerController.convertUrlToId(videoURL);
     _controller = YoutubePlayerController(
      initialVideoId: finalVideoURL ?? "OjzlfDAy1hM",
      params:  YoutubePlayerParams(
        autoPlay: true,
        mute: false,

        startAt: Duration(seconds: 0),
        showControls: true,


      ),
    );

    return Scaffold(
        body: SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
          Expanded(
              child: YoutubePlayerControllerProvider( // Provides controller to all the widget below it.
              controller: _controller,
              child: YoutubePlayerIFrame(
                aspectRatio: 16 / 9,
              ),
            )),
        ])));
  }

}
