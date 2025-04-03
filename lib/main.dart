import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'blidings/my_blidings.dart';
import 'views/home_screen.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
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
