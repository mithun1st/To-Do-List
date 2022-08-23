import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/screen/add_grp.dart';

import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/models/task_m.dart';
import 'package:to_do_list/screen/drawer.dart';
import 'package:to_do_list/store_cls.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State {
  @override
  void initState() {
    groupBox = Hive.box('myBox');
    // groupBox.clear();
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
      drawer: Drawer(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        child: TaskDrawer(),
      ),
      body: ValueListenableBuilder(
        valueListenable: groupBox.listenable(),
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 4,
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
