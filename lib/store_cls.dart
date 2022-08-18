import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/home_page.dart';
import 'models/group_m.dart';

late Box<Group> groupBox;

class Store {
  //Create Group FNC
  void groupAdd(Group g) {
    groupBox.add(g);
  }

  void deleteGroup(int i) {
    groupBox.deleteAt(i);
  }

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
    return GridTile(
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
          title: Text('Task: ${groupBox.getAt(i)!.task.length}'),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              //confirm(ctx);
            },
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 14),
        decoration: BoxDecoration(
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
          //'Dhaka To Rahs',
          groupBox.getAt(i)?.name ?? 'xx',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
