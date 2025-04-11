import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/project_model.dart';
import '../models/task_model.dart';
import '../services/hive_service.dart';
import '../utils/app_colors.dart';
import 'package:hive/hive.dart';

class ProjectController extends GetxController {
  final _hiveService = HiveService();
  final projects = <Project>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadProjects();
  }

  void _loadProjects() {
    projects.value = HiveService.getAllProjects();
  }

  // Get all projects
  List<Project> getAllProjects() {
    return projects;
  }

  // Add new project
  Future<void> addProject({
    required String title,
    Color? color,
  }) async {
    final project = Project(
      title: title,
      color: color ?? AppColors.getRandomProjectColor(),
    );
    await HiveService.addProject(project);
    _loadProjects();
  }

  // Get total project count
  int getProjectCount() {
    return projects.length;
  }

  // Get project progress
  String getProjectProgress(String projectId) {
    return HiveService.getProjectProgress(projectId);
  }

  // Get project statistics
  Map<String, int> getProjectStats() {
    return HiveService.getProjectStats();
  }

  // Delete project
  Future<void> deleteProject(Project project) async {
    // First, delete all tasks associated with this project
    final tasks = HiveService.getTasksForProject(project.key.toString());
    for (var task in tasks) {
      await HiveService.deleteTask(task);
    }
    // Then delete the project itself
    final box = await Hive.openBox<Project>('projects');
    await box.delete(project.key);
    _loadProjects();
  }

  // Update project
  Future<void> updateProject(Project project,
      {String? newTitle, Color? newColor}) async {
    if (newTitle != null) {
      project.title = newTitle;
    }
    if (newColor != null) {
      // ignore: deprecated_member_use
      project.colorValue = newColor.value;
    }
    await project.save();
    _loadProjects();
  }

  Future<void> addTask({
    required String projectId,
    required String title,
    String? description,
    required DateTime dueDate,
  }) async {
    final task = Task(
      title: title,
      description: description ?? '',
      projectId: projectId,
      dueDate: dueDate,
      isCompleted: false,
    );

    final box = await Hive.openBox<Task>('tasks');
    await box.add(task);
    _loadProjects();
  }
}
