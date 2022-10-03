import 'package:flutter/material.dart';
import 'package:to_do_list/controller/data.dart';
import 'package:to_do_list/controller/services.dart';
import 'package:to_do_list/screen/pages/edit_grp.dart';
import 'package:to_do_list/screen/pages/task_scrn.dart';

void confirm(BuildContext ctx, int i) {
  showDialog(
    context: ctx,
    builder: (_) {
      return AlertDialog(
        title: Text('Do you want to Delete?'),
        content: Text('Group- ${groupBox.getAt(i)!.name}'),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              deleteGroup(i);
              Navigator.of(ctx).pop();
            },
            child: Text('Yes'),
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
    key: ValueKey(i),
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
          title: Text(
            '$numOfDone / ${groupBox.getAt(i)!.task.length}',
            textAlign: TextAlign.center,
          ),
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
        padding: const EdgeInsets.only(
          // top: 14,
          bottom: 47,
          left: 4,
          right: 4,
        ),
        alignment: Alignment.center,
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
    onTap: () {
      Navigator.of(ctx).pushNamed(
        TaskPage.routeName,
        arguments: i,
      );
    },
  );
}
