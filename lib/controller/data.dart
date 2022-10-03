import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/models/task_m.dart';

late Box<Group> groupBox;
bool isDark = false;

class Data {
  static registerAdapter() {
    Hive.registerAdapter(GroupAdapter());
    Hive.registerAdapter(TaskAdapter());
  }

  static Future<void> openBox() async {
    await Hive.openBox<Group>('myBox');
    await Hive.openBox<Task>('myTaskBox');
  }
}
