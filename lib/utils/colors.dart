import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.blueAccent;
  static const Color background = Colors.white;
  static const Color surface = Colors.white;
  static const Color error = Colors.red;
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;

  // Design Strip color swatches
  static const List<Color> swatches = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
    Colors.lime,
    Colors.amber,
    Colors.brown,
    Colors.grey,
    Colors.black,
  ];

  // Category colors for different tile types
  static const Map<String, Color> categoryColors = {
    'Ceramic': Colors.orange,
    'Porcelain': Colors.blue,
    'Woodeffect': Colors.brown,
    'Splas': Colors.green,
  };
}
