import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/home_page.dart';
import 'package:to_do_list/models/task_m.dart';
import 'package:to_do_list/screen/edit_grp.dart';
import 'package:to_do_list/screen/task_scrn.dart';
import 'models/group_m.dart';

late Box<Group> groupBox;

class Store {
  List<Color> paperColor = [
    Colors.blue,
    Colors.brown,
    Colors.cyan,
    Colors.green,
    Colors.indigo,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.red,
    Colors.yellow,
  ];

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

  //--------------update task

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

  BoxDecoration selectDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.black,
      width: 4,
    ),
  );
  BoxDecoration unselectDecoration = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.white,
      width: 4,
    ),
  );

  void confirm(BuildContext ctx, int i) {
    showDialog(
      context: ctx,
      builder: (_) {
        return AlertDialog(
          title: Text('Do you want to Delete?'),
          content: Text(groupBox.getAt(i)!.name),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                deleteGroup(i);
                Navigator.of(ctx).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  Widget GroupList(int i, BuildContext ctx) {
    double bRadius = 10;

    int numOfDone = 0;
    groupBox.getAt(i)!.task.forEach(
      (element) {
        if (element.isDone == true) {
          numOfDone++;
        }
      },
    );

    return GestureDetector(
      child: Container(
        child: GridTile(
          footer: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(bRadius),
                bottomRight: Radius.circular(bRadius),
              ),
            ),
            child: GridTileBar(
              leading: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => confirm(ctx, i),
              ),
              title: Text('$numOfDone / ${groupBox.getAt(i)!.task.length}',textAlign: TextAlign.center,),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showModalBottomSheet(
                      context: ctx,
                      builder: (_) {
                        return EditGroup(i);
                      });
                },
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black38,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: .4,
                )
              ],
              borderRadius: BorderRadius.circular(bRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(groupBox.getAt(i)!.color),
                  Color(groupBox.getAt(i)!.color).withOpacity(.7),
                ],
              ),
            ),
            child: Text(
              groupBox.getAt(i)?.name ?? 'xx',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(ctx).pushNamed(
          TaskPage.routeName,
          arguments: i,
        );
      },
    );
  }
}
