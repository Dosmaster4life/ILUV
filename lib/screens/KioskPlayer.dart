import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../Widgets/CreationForm.dart';

class KioskPlayer extends StatefulWidget {
  final String video;
  final Set<String> playlistP;
  KioskPlayer({Key? key, required this.video, required this.playlistP})
      : super(key: key);

  @override
  State<KioskPlayer> createState() => _KioskPlayerState();
}

class _KioskPlayerState extends State<KioskPlayer> {

  @override
  bool checkUpdater = true;
  late YoutubePlayerController _controller;
  String currentVideo = "";

  bool hasRun = false;
  Widget build(BuildContext context) {
    bool mute = false;
    if(kIsWeb) {
      mute = true;
    }
    debugPrint(widget.playlistP.toString());
    String videoURL = widget.video;
    String? finalVideoURL = YoutubePlayerController.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(

      initialVideoId: widget.video,
      params: YoutubePlayerParams(
        playlist: widget.playlistP.toList(),
        mute: mute,
        autoPlay: true,
        loop: true,
        enableKeyboard: true,


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
              child: YoutubePlayerControllerProvider(
            // Provides controller to all the widget below it.
            controller: _controller,
            child: YoutubePlayerIFrame(

              aspectRatio: 16 / 9,
            ),
          )),
        ])));
  }


}
