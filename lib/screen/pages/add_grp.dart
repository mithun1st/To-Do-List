import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_list/controller/services.dart';
import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/screen/theme/theme.dart';
import 'package:to_do_list/screen/widget/store_cls.dart';

class AddGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddGroupState();
  }
}

class AddGroupState extends State<AddGroup> {
  String? errorText = null;
  int colorValue = Random().nextInt(paperColor.length);
  TextEditingController inputCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //int grid count
    double gridCount = (paperColor.length / 2);
    if (paperColor.length.toInt().isOdd) {
      gridCount = (paperColor.length / 2) + 1;
    }

    //
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration:
            BoxDecoration(color: paperColor[colorValue].withOpacity(.4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //--------part 1
            TextField(
              controller: inputCtrl,
              decoration: InputDecoration(
                labelText: 'Group Name',
                prefixIcon: Icon(Icons.group_add),
                errorText: errorText,
                filled: true,
                fillColor: Colors.grey.shade200,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.name,
            ),
            //---------- part 2

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
            //------part 3
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                child: Text('Create Group'),
                onPressed: () {
                  if (inputCtrl.text.isEmpty) {
                    setState(() {
                      errorText = 'Text is Empty';
                    });
                    return;
                  }
                  setState(() {
                    groupAdd(
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
            ),
            //---
          ],
        ),
      ),
    );
  }
}
