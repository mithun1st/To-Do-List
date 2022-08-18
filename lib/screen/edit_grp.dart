import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/store_cls.dart';

class EditGroup extends StatefulWidget {
  int index;
  EditGroup(this.index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditGroupState();
  }
}

class EditGroupState extends State<EditGroup> {
  TextEditingController inputCtrl = TextEditingController();

  String? errorText = null;

  late int colorValue;
  @override
  void initState() {
    int ic = 0;
    Store().paperColor.forEach((element) {
      if (element.value == groupBox.getAt(widget.index)!.color) {
        colorValue = ic;
      }
      ic++;
    });

    inputCtrl.text = groupBox.getAt(widget.index)!.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    double gridCount = (Store().paperColor.length / 2);
    if (Store().paperColor.length.toInt().isOdd) {
      gridCount = (Store().paperColor.length / 2) + 1;
    }

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Store().paperColor[colorValue].withOpacity(.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: inputCtrl,
            decoration: InputDecoration(
                labelText: 'Group Name',
                prefixIcon: Icon(Icons.group_add),
                errorText: errorText,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          //------------2

          Column(
            children: [
              Container(
                width: double.infinity,
                child: Text('Select Color:'),
              ),
              Container(
                height: 150,
                child: GridView.count(
                  primary: false,
                  crossAxisCount: gridCount.toInt(),
                  children: Store().paperColor.map((e) {
                    return IconButton(
                      icon: Container(
                        decoration: colorValue == Store().paperColor.indexOf(e)
                            ? Store().selectDecoration
                            : Store().unselectDecoration,
                        child: CircleAvatar(
                          backgroundColor: e,
                        ),
                      ),
                      onPressed: () {
                        //
                        colorValue = Store().paperColor.indexOf(e);
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
            indent: 20,
            endIndent: 20,
          ),

          //--3
          ElevatedButton(
            child: Text('Edit Group'),
            onPressed: () {
              if (inputCtrl.text.isEmpty) {
                setState(() {
                  errorText = 'Text is Empty';
                });
                return;
              }
              setState(() {
                Group g = Group(
                  name: inputCtrl.text,
                  color: Store().paperColor[colorValue].value,
                  task: groupBox.getAt(widget.index)!.task,
                );
                Store().groupUpdate(widget.index, g);
                errorText = null;
                inputCtrl.clear();
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
