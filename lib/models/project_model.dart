import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

part 'project_model.g.dart';

@HiveType(typeId: 1)
class Project extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  int colorValue;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  String id;

  Project({
    required this.title,
    Color? color,
    DateTime? createdAt,
  })  : colorValue =
            // ignore: deprecated_member_use
            color?.value ?? AppColors.getRandomProjectColor().value,
        createdAt = createdAt ?? DateTime.now(),
        id = DateTime.now().millisecondsSinceEpoch.toString();

  Color get color => Color(colorValue);

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] as String,
      color: Color(json['colorValue'] as int),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'colorValue': colorValue,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
