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
      initialVideoId: 'K18cpp_-gP8',
      params: const YoutubePlayerParams(
        playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'],
        // Defining custom playlist
        startAt: Duration(seconds: 0),
        showControls: true,
        showFullscreenButton: true,
        autoPlay: true,
        strictRelatedVideos: true,

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
