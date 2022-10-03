import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/controller/data.dart';
import 'package:to_do_list/home_page.dart';
import 'package:to_do_list/screen/pages/task_scrn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Data.registerAdapter();
  await Data.openBox();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('-----------------------buildFnc');
    return MaterialApp(
      //home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
        '/': (context) => HomePage(),
        TaskPage.routeName: (context) => TaskPage(),
      },
    );
  }
}
