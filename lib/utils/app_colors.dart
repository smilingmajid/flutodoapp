import 'package:flutter/material.dart';

class AppColors {
  static const List<Color> projectColors = [
    // Neon Blues
    Color(0xFF00FFFF), // Cyan
    Color(0xFF00BFFF), // Deep Sky Blue
    Color(0xFF1E90FF), // Dodger Blue
    Color(0xFF00F5FF), // Electric Blue

    // Neon Purples
    Color(0xFFFF00FF), // Magenta
    Color(0xFFEE82EE), // Violet
    Color(0xFF9400D3), // Dark Violet
    Color(0xFFBA55D3), // Medium Orchid

    // Neon Greens
    Color(0xFF00FF00), // Lime
    Color(0xFF7FFF00), // Chartreuse
    Color(0xFF00FF7F), // Spring Green
    Color(0xFF98FB98), // Pale Green

    // Neon Pinks
    Color(0xFFFF69B4), // Hot Pink
    Color(0xFFFF1493), // Deep Pink
    Color(0xFFFF00FF), // Fuchsia
    Color(0xFFFF66FF), // Light Pink

    // Neon Oranges
    Color(0xFFFF4500), // Orange Red
    Color(0xFFFF6347), // Tomato
    Color(0xFFFF7F50), // Coral
    Color(0xFFFF8C00), // Dark Orange

    // Neon Yellows
    Color(0xFFFFFF00), // Yellow
    Color(0xFFFFD700), // Gold
    Color(0xFFFFE4B5), // Moccasin
    Color(0xFFFFFACD), // Lemon Chiffon

    // Neon Reds
    Color(0xFFFF0000), // Red
    Color(0xFFDC143C), // Crimson
    Color(0xFFFF4444), // Light Red
    Color(0xFFFF6B6B), // Pastel Red

    // Cool Neons
    Color(0xFF40E0D0), // Turquoise
    Color(0xFF48D1CC), // Medium Turquoise
    Color(0xFF7FFFD4), // Aquamarine
    Color(0xFF20B2AA), // Light Sea Green

    // Warm Neons
    Color(0xFFFFA07A), // Light Salmon
    Color(0xFFFFB6C1), // Light Pink
    Color(0xFFDDA0DD), // Plum
    Color(0xFFDA70D6), // Orchid

    // Vibrant Neons
    Color(0xFF32CD32), // Lime Green
    Color(0xFF00CED1), // Dark Turquoise
    Color(0xFF8A2BE2), // Blue Violet
    Color(0xFFFF1493), // Deep Pink
  ];

  static Color getRandomProjectColor() {
    return projectColors[DateTime.now().microsecond % projectColors.length];
  }

  static Color getProjectColorByIndex(int index) {
    return projectColors[index % projectColors.length];
  }
}
