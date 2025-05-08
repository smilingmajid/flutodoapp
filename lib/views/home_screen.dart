import 'dart:ui';
import 'package:line_icons/line_icons.dart';
import '../views/newtaskpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../widgets/project_card_widget.dart';
import '../controllers/project_controller.dart';
import 'package:iconsax/iconsax.dart';
import '../views/add_new_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectController = Get.find<ProjectController>();
    final advancedDrawerController = AdvancedDrawerController();

    return AdvancedDrawer(
      backdropColor: Colors.grey[900],
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900]!,
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: const Offset(-20.0, 0.0),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      drawer: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                // ignore: deprecated_member_use
                Colors.grey[900]!.withOpacity(0.8),
                // ignore: deprecated_member_use
                Colors.grey[900]!.withOpacity(0.6),
              ],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'ClashDisplay',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                ListTile(
                  leading: const Icon(LineIcons.github, color: Colors.white),
                  title: const Text(
                    'Github',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ClashDisplay',
                    ),
                  ),
                  onTap: () {
                    advancedDrawerController.hideDrawer();
                  },
                ),

                //Linkdin
                ListTile(
                  leading:
                      const Icon(LineIcons.linkedinIn, color: Colors.white),
                  title: const Text(
                    'Linkedin',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ClashDisplay',
                    ),
                  ),
                  onTap: () {
                    advancedDrawerController.hideDrawer();
                  },
                ),
                //Telegram
                ListTile(
                  leading: const Icon(LineIcons.telegram, color: Colors.white),
                  title: const Text(
                    'Telegram',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ClashDisplay',
                    ),
                  ),
                  onTap: () {
                    advancedDrawerController.hideDrawer();
                  },
                ),
                ListTile(
                  leading: const Icon(Iconsax.instagram, color: Colors.white),
                  title: const Text(
                    'Instagram',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ClashDisplay',
                    ),
                  ),
                  onTap: () {
                    advancedDrawerController.hideDrawer();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              advancedDrawerController.showDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
        ),
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
                        Obx(() => Text(
                              'Your Projects (${projectController.projects.length})',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'ClashDisplay',
                              ),
                            )),
                      ],
                    ),
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
                                // ignore: deprecated_member_use
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
                              'user_avatar',
                              height: 45,
                              width: 45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Projects Grid
                Expanded(
                  child: Obx(() => projectController.projects.isEmpty
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
                          itemCount: projectController.projects.length,
                          itemBuilder: (context, index) {
                            final project = projectController.projects[index];
                            final progress = projectController
                                .getProjectProgress(project.id);

                            return ProjectCardWidget(
                              title: project.title,
                              progress: progress,
                              subtitle: 'tasks',
                              color: project.color,
                              project: project,
                              gradientColors: [
                                project.color,
                                project.color.withBlue(200),
                              ],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewTaskPage(
                                      projectName: project.title,
                                      projectId: project.id,
                                      backgroundColor: project.color,
                                    ),
                                  ),
                                );
                              },
                              onDelete: () async {
                                await projectController.deleteProject(project);
                              },
                            );
                          },
                        )),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.8),
                  border: Border.all(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewTaskScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
