import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube/youtube_thumbnail.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube/youtube.dart';

class KioskPlayer2 extends StatefulWidget {
  final String video;
  const KioskPlayer2({Key? key, required this.video}) : super(key: key);

  @override
  State<KioskPlayer2> createState() => _KioskPlayerState();
}

class _KioskPlayerState extends State<KioskPlayer2> {
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
    return Expanded(
        child: Drawer(
            width: 100,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Image.network(
                          YoutubeThumbnail(youtubeId: 'Vi-9mvSooCs').small())),
                  Text("Hello"),
                  Flexible(
                      child: YoutubePlayerIFrame(
                    controller: _controller,
                  )),
                  Text("Description")
                ])));
  }
}
