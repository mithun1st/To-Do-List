import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/controller/data.dart';
import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/models/task_m.dart';

//Create Group FNC
void groupAdd(Group g) {
  groupBox.add(g);
}

//Update Group FNC
void groupUpdate(int i, Group g) {
  groupBox.putAt(i, g);
}

//Delete Group FNC
void deleteGroup(int i) {
  groupBox.deleteAt(i);
}

void updateTask(int grpIndex, List<Task> task) {
  groupBox.putAt(
    grpIndex,
    Group(
      name: groupBox.getAt(grpIndex)!.name,
      color: groupBox.getAt(grpIndex)!.color,
      task: task,
    ),
  );
}
