import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/screen/add_grp.dart';

import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/models/task_m.dart';
import 'package:to_do_list/store_cls.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State {
  List<Group> l = [
    Group(
      name: 'g1',
      color: Colors.red.value,
      task: [
        Task(isDone: true, taskName: 't1'),
        Task(isDone: false, taskName: 't2'),
      ],
    ),
    //---
    Group(
      name: 'g2',
      color: Colors.green.value,
      task: [],
    ),
    //--
    Group(
      name: 'g3',
      color: Colors.blue.value,
      task: [
        Task(isDone: true, taskName: 't1'),
        Task(isDone: true, taskName: 't2'),
        Task(isDone: true, taskName: 't3'),
        Task(isDone: false, taskName: 't4'),
        Task(isDone: false, taskName: 't5'),
      ],
    ),
  ];

  @override
  void initState() {
    groupBox = Hive.box('myBox');
    // groupBox.clear();
    groupBox.add(l[0]);
    groupBox.add(l[1]);
    groupBox.add(l[2]);
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void sState() {
    setState(() {});
    print('state change');
  }

//------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('About'),
                value: 'value 1',
                onTap: null,
              ),
              PopupMenuItem(
                child: Text('Setting'),
                value: 'value 2',
                onTap: null,
              ),
            ],
          ),
        ],
      ),
      drawer: Ink(),
      body: ValueListenableBuilder(
        valueListenable: groupBox.listenable(),
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 8,
              left: 8,
              bottom: 2,
            ),
            child: GridView.builder(
              itemCount: groupBox.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) {
                return Store().GroupList(index, context);
              },
            ),
          );
        },
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.group_add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return AddGroup();
              });
        },
      ),
    );
  }
}
