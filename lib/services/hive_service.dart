import 'package:hive_flutter/hive_flutter.dart';


import '../models/task_model.dart';
import '../models/project_model.dart';

class HiveService {
  static const String tasksBoxName = 'tasks';
  static const String projectsBoxName = 'projects';

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(ProjectAdapter());

    // Open Boxes
    await Hive.openBox<Task>(tasksBoxName);
    await Hive.openBox<Project>(projectsBoxName);
  }

  // Project Methods
  static Future<void> addProject(Project project) async {
    final box = Hive.box<Project>(projectsBoxName);
    await box.add(project);
  }

  static List<Project> getAllProjects() {
    final box = Hive.box<Project>(projectsBoxName);
    return box.values.toList();
  }

  static int getProjectCount() {
    final box = Hive.box<Project>(projectsBoxName);
    return box.length;
  }

  static Map<String, int> getProjectStats() {
    final projectBox = Hive.box<Project>(projectsBoxName);
    final taskBox = Hive.box<Task>(tasksBoxName);

    int totalProjects = projectBox.length;
    int totalTasks = taskBox.length;
    int completedTasks =
        taskBox.values.where((task) => task.isCompleted).length;

    return {
      'totalProjects': totalProjects,
      'totalTasks': totalTasks,
      'completedTasks': completedTasks,
      'pendingTasks': totalTasks - completedTasks,
    };
  }

  // Task Methods
  static Future<void> addTask(Task task) async {
    final box = Hive.box<Task>(tasksBoxName);
    await box.add(task);
  }

  static List<Task> getTasksForProject(String projectId) {
    final box = Hive.box<Task>(tasksBoxName);
    return box.values.where((task) => task.projectId == projectId).toList();
  }

  static Future<void> toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await task.save();
  }

  static Future<void> deleteTask(Task task) async {
    await task.delete();
  }

  static String getProjectProgress(String projectId) {
    final tasks = getTasksForProject(projectId);
    if (tasks.isEmpty) return '0/0';

    int completed = tasks.where((task) => task.isCompleted).length;
    return '$completed/${tasks.length}';
  }
}
