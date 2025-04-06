import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import '../services/hive_service.dart';
import '../models/project_model.dart';
import 'package:hive/hive.dart';

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

  // دریافت تمام تسک‌ها گروه‌بندی شده بر اساس پروژه
  Map<String, List<Task>> getAllTasksGroupedByProject() {
    return HiveService.getAllTasksGroupedByProject();
  }

  // دریافت تمام تسک‌ها به همراه اطلاعات پروژه (مرتب شده)
  List<Map<String, dynamic>> getAllTasksWithProjectInfo() {
    final groupedTasks = getAllTasksGroupedByProject();
    final List<Map<String, dynamic>> tasksWithProjects = [];

    for (var entry in groupedTasks.entries) {
      final projectId = entry.key;
      final tasks = entry.value;

      // پیدا کردن پروژه مرتبط
      final project = Hive.box<Project>('projects').values.firstWhere(
            (p) => p.id == projectId,
            orElse: () => Project(title: 'Unknown Project'),
          );

      tasksWithProjects.add({
        'project': project,
        'tasks': tasks,
      });
    }

    // مرتب‌سازی بر اساس نام پروژه
    tasksWithProjects.sort((a, b) => (a['project'] as Project)
        .title
        .compareTo((b['project'] as Project).title));

    return tasksWithProjects;
  }

  // دریافت آمار کلی تسک‌ها بر اساس پروژه
  Map<String, Map<String, int>> getTasksStatsByProject() {
    final groupedTasks = getAllTasksGroupedByProject();
    final Map<String, Map<String, int>> stats = {};

    groupedTasks.forEach((projectId, tasks) {
      final totalTasks = tasks.length;
      final completedTasks = tasks.where((task) => task.isCompleted).length;
      final pendingTasks = totalTasks - completedTasks;

      stats[projectId] = {
        'total': totalTasks,
        'completed': completedTasks,
        'pending': pendingTasks,
      };
    });

    return stats;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
}
