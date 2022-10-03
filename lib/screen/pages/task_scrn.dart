import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/controller/data.dart';
import 'package:to_do_list/controller/services.dart';
import 'package:to_do_list/models/task_m.dart';
import 'package:to_do_list/screen/widget/store_cls.dart';

class TaskPage extends StatefulWidget {
  static String routeName = 'taskPage';

  State createState() {
    return TaskPageState();
  }
}

class TaskPageState extends State<TaskPage> {
  bool isEditing = false;
  late int editIndex;
  TextEditingController taskEditCtrl = TextEditingController();
  TextEditingController taskAddCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int groupIndex = ModalRoute.of(context)!.settings.arguments as int;
    List<Task> task = groupBox.getAt(groupIndex)!.task;
    AppBar appBar = AppBar(
      title: Text(groupBox.getAt(groupIndex)!.name),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(groupBox.getAt(groupIndex)!.color), Colors.black38],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      backgroundColor: Color(groupBox.getAt(groupIndex)!.color),
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Do you want to Delete ?'),
                  content: Text(
                      'All Task of Group- ${groupBox.getAt(groupIndex)!.name}'),
                  backgroundColor: Colors.white,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          task.clear();
                        });
                        updateTask(groupIndex, task);
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      //backgroundColor: Color(groupBox.getAt(index)!.color).withOpacity(1),
      //backgroundColor: Color(groupBox.getAt(index)!.color),
      // backgroundColor: Colors.grey.shade400,
      resizeToAvoidBottomInset: task.isEmpty ? false : true,
      body: Column(
        children: [
          //1st part
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 14,
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
                      setState(() {
                        // task.add(Task(taskName: taskAddCtrl.text, isDone: false));
                        task.insert(
                            0, Task(taskName: taskAddCtrl.text, isDone: false));
                        taskAddCtrl.clear();
                      });
                      updateTask(groupIndex, task);
                    },
                  ),
                ),
              ],
            ),
          ),

          //2nd part
          Flexible(
            fit: FlexFit.tight,
            child: task.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(50),
                        child: const FittedBox(
                          child: Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.black12,
                          ),
                        ),
                      ),
                      Text('Task is Empty!', style: TextStyle(fontSize: 22)),
                    ],
                  )
                : Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: ListView.builder(
                      itemCount: task.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          // color: Colors.grey.shade200,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: Color(groupBox.getAt(groupIndex)!.color),
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    task.removeAt(index);
                                  });
                                  updateTask(groupIndex, task);
                                },
                              ),
                              title: (isEditing && editIndex == index)
                                  ? TextField(
                                      controller: taskEditCtrl,
                                      autofocus: true,
                                    )
                                  : Text(
                                      task[index].taskName,
                                      style: task[index].isDone
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
                                    icon: (isEditing && editIndex == index)
                                        ? const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          )
                                        : const Icon(Icons.edit),
                                    onPressed: () {
                                      setState(() {
                                        editIndex = index;
                                        isEditing = !isEditing;
                                      });
                                      if (isEditing) {
                                        taskEditCtrl.text =
                                            task[index].taskName;
                                      } else {
                                        task[index].taskName =
                                            taskEditCtrl.text;
                                        updateTask(groupIndex, task);
                                      }
                                    },
                                  ),
                                  Checkbox(
                                    value: task[index].isDone,
                                    onChanged: (v) {
                                      setState(() {
                                        task[index].isDone = v!;
                                      });
                                      updateTask(groupIndex, task);
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
    );
  }
}
