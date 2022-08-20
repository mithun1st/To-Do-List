import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/store_cls.dart';

class AddGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddGroupState();
  }
}

class AddGroupState extends State<AddGroup> {
  String? errorText = null;
  int colorValue = Random().nextInt(Store().paperColor.length);
  TextEditingController inputCtrl = TextEditingController();

  var selectDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.black,
      width: 4,
    ),
  );
  

  @override
  Widget build(BuildContext context) {
    //int grid count
    double gridCount = (Store().paperColor.length / 2);
    if (Store().paperColor.length.toInt().isOdd) {
      gridCount = (Store().paperColor.length / 2) + 1;
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
        decoration: BoxDecoration(
            color: Store().paperColor[colorValue].withOpacity(.4)),
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
                        FocusScope.of(context).unfocus();
                        colorValue = Store().paperColor.indexOf(e);
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
                    Store().groupAdd(
                      Group(
                        name: inputCtrl.text,
                        color: Store().paperColor[colorValue].value,
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
