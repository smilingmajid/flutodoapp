import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/project_card_widget.dart';
import '../controllers/project_controller.dart';
import 'task_screen.dart';
import 'add_new_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final projectController = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    final projects = projectController.getAllProjects();
    final projectCount = projectController.getProjectCount();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello, Michael',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'ClashDisplay',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your Projects ($projectCount)',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'ClashDisplay',
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 30,
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Projects Grid
              Expanded(
                child: projects.isEmpty
                    ? const Center(
                        child: Text(
                          'No projects yet.\nTap + to add a new project.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: 'ClashDisplay',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          final project = projects[index];
                          final progress = projectController
                              .getProjectProgress(project.key.toString());

                          return ProjectCardWidget(
                            title: project.title,
                            progress: progress,
                            subtitle: 'tasks',
                            color: project.color,
                            gradientColors: [
                              project.color,
                              project.color.withBlue(200),
                            ],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskScreen(
                                    projectName: project.title,
                                    taskCount: progress,
                                    activeTasks: const [],
                                    completedTasks: const [],
                                    backgroundColor: project.color,
                                  ),
                                ),
                              ).then((_) => setState(() {}));
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
