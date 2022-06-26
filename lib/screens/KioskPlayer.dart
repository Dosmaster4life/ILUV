import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class KioskPlayer extends StatefulWidget {
  const KioskPlayer({Key? key}) : super(key: key);

  @override
  State<KioskPlayer> createState() => _KioskPlayerState();
}

class _KioskPlayerState extends State<KioskPlayer> {
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'aJfhoAzST3A',
      params: const YoutubePlayerParams(
        startAt: Duration(seconds: 0),
        showControls: true,
        showFullscreenButton: true,
        autoPlay: true,


        desktopMode: true,
      ),
    );
    return Scaffold(
        body: SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
          Expanded(
              child: YoutubePlayerIFrame(

            controller: _controller,
          )),
        ])));
  }
}
