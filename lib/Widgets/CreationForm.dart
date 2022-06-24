import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreationForm extends StatefulWidget {
  const CreationForm({Key? key}) : super(key: key);

  @override
  State<CreationForm> createState() => _CreationFormState();
}

class _CreationFormState extends State<CreationForm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row (
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
        Expanded(
           child: Column(

              children: [
                Expanded(
                    flex: 1,
                    child: Container()),
                ElevatedButton.icon(
                  onPressed: () => {
                  }, icon: Icon(Icons.upload_sharp), label: Text("Upload Video"),),
                Expanded(
                  flex: 3,
                    child: Container()),
                ElevatedButton.icon(
                  onPressed: () => {
                  }, icon: Icon(Icons.save), label: Text("Save"),),

              ],

            )),
            Expanded(
           child: Column(
              children:   [

                Text("Title"),
                TextField(
                ),
                Text("Description"),
                TextFormField(
                maxLines: 10,
                ),
                Text("Youtube Link"),
                TextField(

                ),
                Expanded(
                  flex: 3,
                    child: Container()),

                 ElevatedButton.icon(
                        onPressed: () => {
                        }, icon: Icon(Icons.cancel), label: Text("Cancle"),),


              ],
            ))
        ],

    )
    );
  }
}
