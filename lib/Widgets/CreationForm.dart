import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/Home.dart';
import 'AppBars/AppBars.dart';
import 'package:google_fonts/google_fonts.dart';

class CreationForm extends StatefulWidget {
  const CreationForm({Key? key, required this.documentExistString})
      : super(key: key);
  final String documentExistString;

  @override
  State<CreationForm> createState() => _CreationFormState();
}

class _CreationFormState extends State<CreationForm> {
  @override
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();

  Future<void> saveItem() async {
    DocumentReference createPost;
    if (widget.documentExistString == "") {
      createPost = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc();
    } else {
      createPost = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(widget.documentExistString);
    }

    return createPost.set({
      'URL': urlController.text,
      'Title': titleController.text,
      'Description': descriptionController.text,
      'Coordinates': ("0:0"),
      'Time Created': Timestamp.now(),
    }, SetOptions(merge: true)).then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home())));
  }

  void getDocumentData() {
    DocumentReference doc = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc(widget.documentExistString);
    doc.get().then((DocumentSnapshot ds) {
      if (ds.exists) {
        titleController.text = ds["Title"];
        descriptionController.text = ds["Description"];
        urlController.text = ds["URL"];
      }
    });
  }

  void deleteDocument() {
    FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .doc(widget.documentExistString)
        .delete();
  }

  Widget build(BuildContext context) {
    if (widget.documentExistString != "") {
      getDocumentData();
    }

    String appBarTitle = "Add Video";
    if (widget.documentExistString != "") {
      appBarTitle = "Edit Video";
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBars(
          ID: 3,
          title: appBarTitle,
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              children: [
                Text(
                  "Title",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
                Center(
                  child: TextField(
                    controller: titleController,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text("Description"),
                Center(
                  child: TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text("Youtube Link"),
                Center(
                  child: TextField(
                    controller: urlController,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(flex: 3, child: Container()),
                Row(children: [
                  SaveButton(context),
                  CancelButton(context),
                  DeleteButton(context)
                ]),
              ],
            ))
          ],
        )));
  }

  Padding SaveButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () => {
          saveItem(),
        },
        icon: Icon(Icons.save),
        label: Text(
          "Save",
          style: GoogleFonts.montserrat(),
        ),
      ),
    );
  }

  Padding CancelButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () => {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home())),
          },
          icon: Icon(Icons.cancel),
          label: Text("Cancel"),
        ));
  }

  Widget DeleteButton(BuildContext context) {
    if (widget.documentExistString == "") {
      return Container();
    } else {
      return Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () => {
              deleteDocument(),
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home())),
            },
            icon: Icon(Icons.delete),
            label: Text("Delete"),
          ));
    }
  }
}
