import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import '../services/hive_service.dart';

class TaskController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Get all tasks for a project
  List<Task> getTasksForProject(String projectId) {
    return HiveService.getTasksForProject(projectId);
  }

  // Add new task
  Future<void> addTask({
    required String projectId,
  }) async {
    final task = Task(
      title: titleController.text,
      projectId: projectId,
      description: descriptionController.text,
    );
    await HiveService.addTask(task);
  }

  // Update task
  Future<void> updateTask(
    Task task, {
    String? newTitle,
    String? newDescription,
    DateTime? newDueDate,
    bool? isCompleted,
  }) async {
    if (newTitle != null) {
      task.title = newTitle;
    }
    if (newDescription != null) {
      task.description = newDescription;
    }
    if (newDueDate != null) {
      task.dueDateValue = newDueDate;
    }
    if (isCompleted != null) {
      task.isCompleted = isCompleted;
    }
    await task.save();
  }

  // Delete task
  Future<void> deleteTask(Task task) async {
    await HiveService.deleteTask(task);
  }

  // Toggle task completion status
  Future<void> toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await task.save();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
}
