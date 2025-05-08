// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/task_model.dart';
import '../services/hive_service.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';

class NewTaskPage extends StatefulWidget {
  final String projectName;
  final String projectId;
  final Color backgroundColor;

  const NewTaskPage({
    super.key,
    required this.projectName,
    required this.projectId,
    required this.backgroundColor,
  });

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final taskController = Get.find<TaskController>();
  final TextEditingController _newTaskController = TextEditingController();
  DateTime? _selectedDueDate;

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = taskController.getTasksForProject(widget.projectId);
    final activeTasks = tasks.where((task) => !task.isCompleted).toList();
    final completedTasks = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.backgroundColor,
              widget.backgroundColor.withBlue(200),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Transparent circle at the top
              Positioned(
                top: -50,
                right: -50,
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // ignore: duplicate_ignore
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),
                  ),
                ),
              ),

              // Main content
              Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button with glass effect
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                child: Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.4),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new,
                                    color: Colors.white, size: 24),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                        // Avatar with glass effect
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                child: Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: RandomAvatar(
                                  DateTime.now().toString(),
                                  height: 45,
                                  width: 45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Project title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.projectName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ClashDisplay',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 3,
                              height: 20,
                              color: Colors.white.withOpacity(0.5),
                              margin: const EdgeInsets.only(right: 10),
                            ),
                            Text(
                              '${tasks.length} Tasks',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                                fontFamily: 'ClashDisplay',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Add new task input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _newTaskController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Add new task...',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontFamily: 'ClashDisplay',
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            if (_newTaskController.text.isNotEmpty) {
                              final task = Task(
                                title: _newTaskController.text,
                                projectId: widget.projectId,
                                dueDate: _selectedDueDate,
                              );
                              HiveService.addTask(task);
                              _newTaskController.clear();
                              _selectedDueDate = null;
                              setState(() {});
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today,
                              color: Colors.white),
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() {
                                _selectedDueDate = date;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tasks list
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          // Active tasks
                          Text(
                            'In Progress',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ...activeTasks.map((task) => _buildTaskItem(task)),

                          // Divider
                          if (completedTasks.isNotEmpty) ...[
                            const SizedBox(height: 30),
                            Container(
                              height: 2,
                              color: Colors.grey[100],
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                            const SizedBox(height: 30),

                            // Completed tasks
                            Row(
                              children: [
                                Text(
                                  'Completed',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '(${completedTasks.length})',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ...completedTasks
                                .map((task) => _buildTaskItem(task)),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        //border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () async {
              await taskController.toggleTaskCompletion(task);
              setState(() {});
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: task.isCompleted ? Colors.green : Colors.grey[400]!,
                  width: 1,
                ),
                color: task.isCompleted ? Colors.green : Colors.transparent,
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 15),
          // Task title and due date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: task.isCompleted ? Colors.grey : Colors.black87,
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
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
          ),
          // Delete button
          IconButton(
            icon: const Icon(Iconsax.trash, color: Colors.red),
            onPressed: () async {
              await taskController.deleteTask(task);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
