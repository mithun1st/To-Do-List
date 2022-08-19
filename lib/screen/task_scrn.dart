import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/models/task_m.dart';
import 'package:to_do_list/store_cls.dart';

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
    );
    return Scaffold(
      appBar: appBar,
      //backgroundColor: Color(groupBox.getAt(index)!.color).withOpacity(1),
      //backgroundColor: Color(groupBox.getAt(index)!.color),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: TextField(
                    controller: taskAddCtrl,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.task),
                      labelText: 'Task Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  icon: Text('Add Task'),
                  label: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      task.add(Task(taskName: taskAddCtrl.text, isDone: false));
                      taskAddCtrl.clear();
                    });
                    Store().updateTask(groupIndex, task);
                  },
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              child: ListView.builder(
                //reverse: true,
                //,
                itemCount: task.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            task.removeAt(index);
                          });
                          Store().updateTask(groupIndex, task);
                        },
                      ),
                      title: (isEditing && editIndex == index)
                          ? TextField(controller: taskEditCtrl)
                          : Text(
                              task[index].taskName,
                              style: task[index].isDone
                                  ? const TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                    )
                                  : const TextStyle(
                                      //color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                            ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon((isEditing && editIndex == index)
                                  ? Icons.done
                                  : Icons.edit),
                              onPressed: () {
                                setState(() {
                                  editIndex = index;
                                  isEditing = !isEditing;
                                });
                                if (isEditing) {
                                  taskEditCtrl.text = task[index].taskName;
                                } else {
                                  task[index].taskName = taskEditCtrl.text;
                                  Store().updateTask(groupIndex, task);
                                }
                              },
                            ),
                            Checkbox(
                              value: task[index].isDone,
                              onChanged: (v) {
                                setState(() {
                                  task[index].isDone = v!;
                                });
                                Store().updateTask(groupIndex, task);
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