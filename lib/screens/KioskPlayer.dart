import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class KioskPlayer extends StatefulWidget {
  final String video;
  const KioskPlayer({Key? key, required this.video}) : super(key: key);

  @override
  State<KioskPlayer> createState() => _KioskPlayerState();
}

class _KioskPlayerState extends State<KioskPlayer> {
  @override
  Widget build(BuildContext context) {
    String videoURL = widget.video ?? "";
    String? finalVideoURL = YoutubePlayerController.convertUrlToId(videoURL);
    YoutubePlayerController _controller = YoutubePlayerController(

      initialVideoId: finalVideoURL ?? "OjzlfDAy1hM",
      params: const YoutubePlayerParams(
        autoPlay: true,
        startAt: Duration(seconds: 0),

        showControls: false,
        showFullscreenButton: true,
        enableJavaScript: true,


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
