import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/AppBars/AppBars.dart';
import 'CreateItem.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
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
            return Card(
                child: ListTile(
                  onTap: () async {

                  },
                  title: new Text(document["Title"]),
                ));
        }).toList(),
      );
    }

    );
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      body: buildStreamBuilder(),
      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateItem()),
        );
      },

      ),
      appBar: AppBars(ID: 0, title: "Home"),

    );
  }
}
