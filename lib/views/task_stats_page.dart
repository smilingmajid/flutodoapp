import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/project_model.dart';
import '../models/task_model.dart';
import 'package:intl/intl.dart';

class TaskStatsPage extends StatelessWidget {
  const TaskStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();
    final tasksWithProjects = taskController.getAllTasksWithProjectInfo();
    final stats = taskController.getTasksStatsByProject();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'آمار تسک‌ها',
          style: TextStyle(
            fontFamily: 'ClashDisplay',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // آمار کلی
          _buildTotalStatsCard(stats),
          const SizedBox(height: 20),

          // لیست پروژه‌ها و تسک‌هایشان
          ...tasksWithProjects.map((item) {
            final project = item['project'] as Project;
            final tasks = item['tasks'] as List<Task>;
            final projectStats =
                stats[project.id] ?? {'total': 0, 'completed': 0, 'pending': 0};

            return _buildProjectCard(
              context,
              project,
              tasks,
              projectStats,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTotalStatsCard(Map<String, Map<String, int>> stats) {
    int totalTasks = 0;
    int totalCompleted = 0;
    int totalPending = 0;

    stats.forEach((_, projectStats) {
      totalTasks += projectStats['total'] ?? 0;
      totalCompleted += projectStats['completed'] ?? 0;
      totalPending += projectStats['pending'] ?? 0;
    });

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'آمار کلی',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'ClashDisplay',
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('کل تسک‌ها', totalTasks, Colors.blue),
              _buildStatItem('تکمیل شده', totalCompleted, Colors.green),
              _buildStatItem('در حال انجام', totalPending, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.task, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    Project project,
    List<Task> tasks,
    Map<String, int> projectStats,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: project.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.folder,
                  color: project.color,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'ClashDisplay',
                      ),
                    ),
                    Text(
                      '${projectStats['total']} تسک',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              _buildProgressIndicator(projectStats),
            ],
          ),
          const SizedBox(height: 15),
          if (tasks.isNotEmpty) ...[
            const Divider(),
            const SizedBox(height: 10),
            ...tasks.map((task) => _buildTaskItem(task)).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(Map<String, int> stats) {
    final total = stats['total'] ?? 0;
    final completed = stats['completed'] ?? 0;
    final progress = total > 0 ? completed / total : 0.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              progress == 1.0 ? Colors.green : Colors.blue,
            ),
          ),
        ),
        Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: task.isCompleted ? Colors.green : Colors.orange,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                fontSize: 14,
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
                color: task.isCompleted ? Colors.grey : Colors.black87,
              ),
            ),
          ),
          if (task.dueDate != null)
            Text(
              DateFormat('MMM dd').format(task.dueDate!),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
    );
  }
}
