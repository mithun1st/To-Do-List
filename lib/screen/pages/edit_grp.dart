import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_list/controller/data.dart';
import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/screen/theme/theme.dart';
import 'package:to_do_list/screen/widget/store_cls.dart';

import '../../controller/services.dart';

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
    paperColor.forEach((element) {
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
    double gridCount = (paperColor.length / 2);
    if (paperColor.length.toInt().isOdd) {
      gridCount = (paperColor.length / 2) + 1;
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: paperColor[colorValue].withOpacity(.4),
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
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            //------------2

            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text('Select Color:'),
                ),
                GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  crossAxisCount: gridCount.toInt(),
                  children: paperColor.map((e) {
                    return IconButton(
                      icon: Container(
                        decoration: colorValue == paperColor.indexOf(e)
                            ? selectDecoration
                            : unselectDecoration,
                        child: CircleAvatar(
                          backgroundColor: e,
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        colorValue = paperColor.indexOf(e);
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),

            //--3
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                child: Text('Update Group'),
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
                      color: paperColor[colorValue].value,
                      task: groupBox.getAt(widget.index)!.task,
                    );
                    groupUpdate(widget.index, g);
                    errorText = null;
                    inputCtrl.clear();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
