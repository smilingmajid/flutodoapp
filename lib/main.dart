import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blidings/my_blidings.dart';
import 'views/home_screen.dart';
import 'services/hive_service.dart';
import 'models/project_model.dart';
import 'models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(TaskAdapter());

  // Open Boxes
  await Hive.openBox<Project>('projects');
  await Hive.openBox<Task>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBindings(),
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'ClashDisplay',
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'ClashDisplay'),
          displayMedium: TextStyle(fontFamily: 'ClashDisplay'),
          displaySmall: TextStyle(fontFamily: 'ClashDisplay'),
          headlineLarge: TextStyle(fontFamily: 'ClashDisplay'),
          headlineMedium: TextStyle(fontFamily: 'ClashDisplay'),
          headlineSmall: TextStyle(fontFamily: 'ClashDisplay'),
          titleLarge: TextStyle(fontFamily: 'ClashDisplay'),
          titleMedium: TextStyle(fontFamily: 'ClashDisplay'),
          titleSmall: TextStyle(fontFamily: 'ClashDisplay'),
          bodyLarge: TextStyle(fontFamily: 'ClashDisplay'),
          bodyMedium: TextStyle(fontFamily: 'ClashDisplay'),
          bodySmall: TextStyle(fontFamily: 'ClashDisplay'),
          labelLarge: TextStyle(fontFamily: 'ClashDisplay'),
          labelMedium: TextStyle(fontFamily: 'ClashDisplay'),
          labelSmall: TextStyle(fontFamily: 'ClashDisplay'),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
