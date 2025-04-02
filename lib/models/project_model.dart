import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'project_model.g.dart';

@HiveType(typeId: 1)
class Project extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  int colorValue;

  @HiveField(2)
  DateTime createdAt;

  Project({
    required this.title,
    required Color color,
    DateTime? createdAt,
  })  : this.colorValue = color.value,
        this.createdAt = createdAt ?? DateTime.now();

  Color get color => Color(colorValue);
}
