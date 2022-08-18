import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/store_cls.dart';

class ModalSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ModalSheetState();
  }
}

class ModalSheetState extends State<ModalSheet> {
  List<Color> paperColor = [
    Colors.red,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.cyan,
  ];
  int colorValue = Random().nextInt(6);

  TextEditingController inputCtrl = TextEditingController();

  String? errorText = null;

  var selectDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.black,
      width: 3,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: paperColor[colorValue].withOpacity(.4)),
      child: Column(children: [
        TextField(
          controller: inputCtrl,
          decoration: InputDecoration(
              labelText: 'Group Name',
              prefixIcon: Icon(Icons.group_add),
              errorText: errorText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        ),
        //------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: paperColor.map((e) {
            return IconButton(
              icon: Container(
                decoration: colorValue == paperColor.indexOf(e)
                    ? selectDecoration
                    : null,
                child: CircleAvatar(
                  backgroundColor: e,
                ),
              ),
              onPressed: () {
                //
                colorValue = paperColor.indexOf(e);
                setState(() {});
              },
            );
          }).toList(),
        ),

        //--
        ElevatedButton(
          child: Text('Create Group'),
          onPressed: () {
            if (inputCtrl.text.isEmpty) {
              setState(() {
                errorText = 'Text is Empty';
              });
              return;
            }
            setState(() {
              Store().groupAdd(
                Group(
                  name: inputCtrl.text,
                  color: paperColor[colorValue].value,
                  task: [],
                ),
              );
              //
              errorText = null;
              inputCtrl.clear();
            });
            Navigator.of(context).pop();
          },
        ),
      ]),
    );
  }
}
