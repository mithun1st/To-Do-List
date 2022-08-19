import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/home_page.dart';
import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/models/task_m.dart';
import 'package:to_do_list/screen/task_scrn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(GroupAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Group>('myBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        TaskPage.routeName: (context) => TaskPage(),
      },
    );
  }
}
