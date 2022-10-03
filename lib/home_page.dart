import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/controller/data.dart';
import 'package:to_do_list/controller/services.dart';
import 'package:to_do_list/models/group_m.dart';
import 'package:to_do_list/screen/pages/add_grp.dart';
import 'package:to_do_list/screen/pages/drawer.dart';
import 'package:to_do_list/screen/widget/store_cls.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

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

  // void sState() {
  //   setState(() {});
  //   print('state change');
  // }

//------------------------------
  @override
  Widget build(BuildContext context) {
    print('-----------------------buildFnc1');
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text('To Do List'),
        centerTitle: true,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Text('DarkMode'),
              Switch(
                value: isDark,
                onChanged: (value) {
                  setState(() {
                    isDark = value;
                  });
                },
              )
            ],
          ),
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('About'),
                value: 'value 1',
              ),
              PopupMenuItem(
                child: Text('Setting'),
                value: 'value 2',
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
            //-------
            child: ReorderableGridView.builder(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    Group? grp = groupBox.getAt(oldIndex);
                    groupBox.putAt(oldIndex, groupBox.getAt(newIndex)!);
                    groupBox.putAt(newIndex, grp!);
                  });
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: groupBox.length,
                itemBuilder: (context, index) {
                  return GroupList(index, context);
                }),
            //-------\
          );
        },
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.edit_note_rounded,
          size: 40,
        ),
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
