import 'package:flutter/material.dart';
import 'add_new_screen.dart';
import 'task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              Row(
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
                      const SizedBox(height: 8),
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
                    /*
                    backgroundImage: NetworkImage(
                      'https://example.com/placeholder.jpg', // جایگزین با تصویر واقعی
                    ),*/
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
                    ProjectCard(
                      title: 'Holidays\nin Norway',
                      progress: '8/10',
                      subtitle: 'tasks',
                      color: Colors.blue,
                      gradientColors: [Colors.blue, Colors.blue.shade800],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskScreen(
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
                    ProjectCard(
                      title: 'Daily\nTasks',
                      progress: '2/4',
                      subtitle: 'tasks',
                      color: Colors.orange,
                      gradientColors: [Colors.orange, Colors.deepOrange],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskScreen(
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

class ProjectCard extends StatelessWidget {
  final String title;
  final String progress;
  final String subtitle;
  final Color color;
  final List<Color> gradientColors;
  final VoidCallback? onTap;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.progress,
    required this.subtitle,
    required this.color,
    required this.gradientColors,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        progress,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.more_horiz, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddNewTaskScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
