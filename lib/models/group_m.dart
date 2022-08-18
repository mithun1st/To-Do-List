import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/models/task_m.dart';

part 'group_m.g.dart';

@HiveType(typeId: 1)
class Group {
  @HiveField(0)
  String name;

  @HiveField(1)
  int color;

  @HiveField(2)
  List<Task> task;

  Group({
    required this.name,
    required this.color,
    required this.task,
  });
}
