import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/Home.dart';
import 'AppBars/AppBars.dart';

class CreationForm extends StatefulWidget {
  const CreationForm({Key? key, required this.documentExistString}) : super(key: key);
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
    if(widget.documentExistString != "") {
      createPost = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc();
    }else {
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
    }, SetOptions(merge: true))
        .then((value) =>  Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Home())));
  }




  void getDocumentData() {
    DocumentReference doc = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc(widget.documentExistString);
    doc.get()
        .then((DocumentSnapshot ds) {
      if (ds.exists) {
        titleController.text = ds["Title"];
        descriptionController.text = ds["Description"];
        urlController.text = ds["URL"];
      }
    });
  }
  Widget build(BuildContext context) {
    if (widget.documentExistString != "") {
      getDocumentData();
    }

    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBars(
        ID: 3,
        title: "Add Video",),
    body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                    children: [
                      Expanded(flex: 1, child: Container()),

                      Expanded(flex: 3, child: Container()),
                      ElevatedButton.icon(
                        onPressed: () =>
                        {
                          saveItem(),
                        },
                        icon: Icon(Icons.save),
                        label: Text("Save"),
                      ),
                    ],
                  )),
              Expanded(
                  child: Column(
                    children: [
                      Text("Title"),
                      TextField(
                        controller: titleController,
                      ),
                      Text("Description"),
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                      ),
                      Text("Youtube Link"),
                      TextField(
                        controller: urlController,
                      ),
                      Expanded(flex: 3, child: Container()),
                      ElevatedButton.icon(
                        onPressed: () =>
                        {
                          MaterialPageRoute(
                              builder: (context) => const Home())
                        },
                        icon: Icon(Icons.cancel),
                        label: Text("Cancel"),
                      ),
                    ],
                  ))
            ],
          )));

  }


}
