import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/models/task_m.dart';
import 'package:to_do_list/store_cls.dart';

class TaskDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskDrawerState();
  }
}

class TaskDrawerState extends State {
  late Box<Task> taskBox;
  List<Task> task = [];
  bool isEditing = false;
  late int editIndex;
  TextEditingController taskEditCtrl = TextEditingController();
  TextEditingController taskAddCtrl = TextEditingController();
  ScrollController sCtrl = ScrollController();

//-----------------------------CRUD
  void addTask(Task t) async {
    taskBox.add(t);
  }

  void updateTask(int i, Task t) {
    taskBox.putAt(i, t);
  }

  void deleteTask(int i) {
    taskBox.deleteAt(i);
  }

  @override
  void initState() {
    taskBox = Hive.box('myTaskBox');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Quick Task'),
          centerTitle: true,
          backgroundColor: Colors.black45,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 20,
              ),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: TextField(
                      controller: taskAddCtrl,
                      //style: TextStyle(color: Colors.red),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.task),
                        labelText: 'Task Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            width: 4,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: TextButton.icon(
                      icon: Text('Add Task'),
                      label: Icon(Icons.add),
                      onPressed: () {
                        addTask(
                          Task(taskName: taskAddCtrl.text, isDone: false),
                        );
                        setState(() {
                          taskAddCtrl.clear();
                        });
                        // sCtrl.jumpTo(
                        //   sCtrl.position.maxScrollExtent + 65,
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 4,
              indent: 10,
              endIndent: 10,
            ),
            //-----------------------------------------
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 3,
                  right: 3,
                  //bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: ListView.builder(
                  controller: sCtrl,
                  itemCount: taskBox.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8,
                      // color: Colors.grey.shade200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            //color: Color(groupBox.getAt(groupIndex)!.color),
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                deleteTask(index);
                              });
                              //Store().updateTask(groupIndex, task);
                            },
                          ),
                          title: (isEditing && editIndex == index)
                              ? TextField(
                                  controller: taskEditCtrl,
                                  autofocus: true,
                                )
                              : Text(
                                  taskBox.getAt(index)!.taskName,
                                  style: taskBox.getAt(index)!.isDone
                                      ? const TextStyle(
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )
                                      : const TextStyle(
                                          //color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  (isEditing && editIndex == index)
                                      ? Icons.done
                                      : Icons.edit,
                                ),
                                onPressed: () {
                                  setState(() {
                                    editIndex = index;
                                    isEditing = !isEditing;
                                  });
                                  if (isEditing) {
                                    taskEditCtrl.text =
                                        taskBox.getAt(index)!.taskName;
                                  } else {
                                    Task t = Task(
                                      taskName: taskEditCtrl.text,
                                      isDone: taskBox.getAt(index)!.isDone,
                                    );
                                    updateTask(index, t);
                                  }
                                },
                              ),
                              Checkbox(
                                value: taskBox.getAt(index)!.isDone,
                                onChanged: (v) {
                                  Task t = Task(
                                      taskName: taskBox.getAt(index)!.taskName,
                                      isDone: v!);
                                  updateTask(index, t);
                                  setState(() {});
                                  //Store().updateTask(groupIndex, task);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
