import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/project_model.dart';
import '../services/hive_service.dart';
import '../utils/app_colors.dart';

class ProjectController extends GetxController {
  // Get all projects
  List<Project> getAllProjects() {
    return HiveService.getAllProjects();
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
  }

  // Get total project count
  int getProjectCount() {
    return HiveService.getProjectCount();
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
    await project.delete();
  }

  // Update project
  Future<void> updateProject(Project project,
      {String? newTitle, Color? newColor}) async {
    if (newTitle != null) {
      project.title = newTitle;
    }
    if (newColor != null) {
      project.colorValue = newColor.value;
    }
    await project.save();
  }
}
