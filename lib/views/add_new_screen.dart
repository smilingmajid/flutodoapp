import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/show_project_controller.dart';
import '../controllers/project_controller.dart';
import '../models/project_model.dart';
import '../widgets/close_button_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  String selectedProject = '';
  bool isToday = true;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addprojectController = TextEditingController();
  final showprojectController = Get.find<ShowProjectController>();
  final projectController = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    final projects = projectController.getAllProjects();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                closeButtonWidget(context),
                const SizedBox(height: 30),
                const Text('New Task',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'ClashDisplay')),
                const SizedBox(height: 30),
                _buildDateSelection(),
                const SizedBox(height: 20),
                _buildIconsRow(),
                const SizedBox(height: 30),
                const Text('PROJECTS',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'ClashDisplay')),
                const SizedBox(height: 15),
                _buildProjectList(projects),
                const SizedBox(height: 30),
                Obx(
                  () => showprojectController.showProject.value
                      ? _buildTextField('PROJECT', 'Enter project name',
                          _addprojectController)
                      : const SizedBox(),
                ),
                const SizedBox(height: 15),
                _buildTextField('TITLE', 'Enter task title', _titleController),
                const SizedBox(height: 15),
                _buildTextField('DESCRIPTION', 'Description (optional)',
                    _descriptionController),
                const SizedBox(height: 30),
                _buildCreateButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return Row(
      children: [
        _buildDateButton(
            'Today', isToday, () => setState(() => isToday = true)),
        const SizedBox(width: 15),
        _buildDateButton(
            'Tomorrow', !isToday, () => setState(() => isToday = false)),
      ],
    );
  }

  Widget _buildDateButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border:
              Border.all(color: isSelected ? Colors.black : Colors.grey[300]!),
        ),
        child: Text(
          label,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'ClashDisplay'),
        ),
      ),
    );
  }

  Widget _buildIconsRow() {
    return Row(
      children: [
        _buildIconButton(Icons.access_time),
        const SizedBox(width: 15),
        _buildIconButton(Icons.flag_outlined),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Icon(icon, color: Colors.black),
    );
  }

  Widget _buildProjectList(List<Project> projects) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
                onTap: () {
                  showprojectController.changeShowProject();
                },
                child:
                    _buildProjectChip(icon: Icons.add, label: '', isAdd: true));
          }
          final project = projects[index - 1];
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: _buildProjectChip(
              backgroundColor: project.color,
              label: project.title,
              isSelected: selectedProject == project.title,
              onTap: () {
                setState(() {
                  selectedProject = project.title;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectChip({
    IconData? icon,
    required String label,
    Color backgroundColor = Colors.white,
    bool isSelected = false,
    bool isAdd = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isAdd ? 12 : 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isAdd ? Colors.white : backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isAdd ? Colors.grey[300]! : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, size: 20, color: Colors.black),
            if (!isAdd) ...[
              Text(
                label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'ClashDisplay'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String title, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: 'ClashDisplay')),
        const SizedBox(height: 15),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (showprojectController.showProject.value) {
            if (_addprojectController.text.isNotEmpty) {
              await projectController.addProject(
                title: _addprojectController.text,
              );
              showprojectController.changeShowProject();
              _addprojectController.clear();
              setState(() {});
            }
          } else {
            if (_titleController.text.isNotEmpty &&
                selectedProject.isNotEmpty) {
              Navigator.pop(context);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Create Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'ClashDisplay',
          ),
        ),
      ),
    );
  }
}
