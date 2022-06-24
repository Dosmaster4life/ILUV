import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iluv/Widgets/AppBars/AppBars.dart';
import 'package:iluv/Widgets/CreationForm.dart';

class CreateItem extends StatefulWidget {
  const CreateItem({Key? key}) : super(key: key);

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBars(ID: 3,title: "Add Video",),
      body: CreationForm(),
    );
  }
}
