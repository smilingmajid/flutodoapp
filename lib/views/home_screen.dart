import 'package:flutter/material.dart';
import '../widgets/project_card_widget.dart';
import 'task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Michael',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Your Projects (4)',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Projects Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                  mainAxisSpacing: 15,
                  children: [
                    // Norway Project Card
                    ProjectCardWidget(
                      title: 'Holidays\nin Norway',
                      progress: '8/10',
                      subtitle: 'tasks',
                      color: Colors.blue,
                      gradientColors: [Colors.blue, Colors.blue.shade800],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TaskScreen(
                              projectName: 'Holidays in Norway',
                              taskCount: '8/10',
                              activeTasks: [
                                'Book flight tickets',
                                'Reserve hotel rooms',
                              ],
                              completedTasks: [
                                'Research tourist attractions',
                                'Create travel itinerary',
                              ],
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        );
                      },
                    ),

                    // Daily Tasks Card
                    ProjectCardWidget(
                      title: 'Daily\nTasks',
                      progress: '2/4',
                      subtitle: 'tasks',
                      color: Colors.orange,
                      gradientColors: const [Colors.orange, Colors.deepOrange],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TaskScreen(
                              projectName: 'Daily Tasks',
                              taskCount: '2/4',
                              activeTasks: [
                                'Create a presentation in Keynote',
                                'Give feedback to the team',
                              ],
                              completedTasks: [
                                'Book the return tickets',
                                'Check some guided tours',
                              ],
                              backgroundColor: Colors.orange,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
