import 'package:flutter/material.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  String selectedProject = 'Holidays in Norway';
  bool isToday = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Center(
                    child: Icon(Icons.close, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Title
              const Text(
                'New Task',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Date Selection
              Row(
                children: [
                  // Today Button
                  GestureDetector(
                    onTap: () => setState(() => isToday = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isToday ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isToday ? Colors.black : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          color: isToday ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Tomorrow Button
                  GestureDetector(
                    onTap: () => setState(() => isToday = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: !isToday ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: !isToday ? Colors.black : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        'Tomorrow',
                        style: TextStyle(
                          color: !isToday ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Time and Priority Buttons
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: const Icon(Icons.access_time, color: Colors.black),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: const Icon(Icons.flag_outlined, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Projects Section
              const Text(
                'PROJECTS',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildProjectChip(
                      icon: Icons.add,
                      label: '',
                      isAdd: true,
                    ),
                    const SizedBox(width: 10),
                    _buildProjectChip(
                      backgroundColor: Colors.blue,
                      label: 'Holidays in Norway',
                      isSelected: selectedProject == 'Holidays in Norway',
                    ),
                    const SizedBox(width: 10),
                    _buildProjectChip(
                      backgroundColor: Colors.orange,
                      label: 'Daily Tasks',
                      isSelected: selectedProject == 'Daily Tasks',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Title Section
              const Text(
                'TITLE',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Purchase travel insurance',
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
              const SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Description (optional)',
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

              const Spacer(),
              // Create Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement task creation
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectChip({
    IconData? icon,
    required String label,
    Color backgroundColor = Colors.white,
    bool isSelected = false,
    bool isAdd = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isAdd) {
          setState(() => selectedProject = label);
        }
      },
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
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
