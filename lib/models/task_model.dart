import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String projectId;

  @HiveField(2)
  String? description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  DateTime? dueDate;

  @HiveField(5)
  DateTime createdAt;

  Task({
    required this.title,
    required this.projectId,
    this.description,
    this.dueDate,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  set dueDateValue(DateTime? value) {
    dueDate = value;
  }
}
