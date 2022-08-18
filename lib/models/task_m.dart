import 'package:hive/hive.dart';
part 'task_m.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  bool isDone;

  Task({
    required this.taskName,
    required this.isDone,
  });
}
