import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/screens/KioskPlayer.dart';

class AdminViewMode extends StatefulWidget {
  const AdminViewMode({Key? key}) : super(key: key);

  @override
  State<AdminViewMode> createState() => _AdminViewModeState();
}

class _AdminViewModeState extends State<AdminViewMode> {
  @override
  int currentVideo = 0;
  final Stream _usersStream = FirebaseFirestore.instance.collection(
      FirebaseAuth.instance.currentUser!.uid).doc("Admin").snapshots();
  final Stream<DocumentSnapshot> _usersStream2 =
  FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("Admin").snapshots(includeMetadataChanges: true);
  String oldVideo = "";
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream2,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if(oldVideo != snapshot.data!["Video"]) {

          oldVideo = snapshot.data!["Video"];

        }
        debugPrint(snapshot.data!["Video"]);
        try {
          return  KioskPlayer(key: ValueKey(snapshot.data!["Video"]),video: snapshot.data!["Video"]);
        }catch(e) {
          return Text(snapshot.data!["Video"]);
        }


      },
    );
  }
}


