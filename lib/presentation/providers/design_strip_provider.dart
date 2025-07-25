import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DesignStripProvider extends ChangeNotifier {
  final List<Color> _selectedColors = [];
  final List<TextEditingController> _controllers = [];
  final List<bool> _isValidHex = [];

  List<Color> get selectedColors => _selectedColors;
  List<TextEditingController> get controllers => _controllers;
  List<bool> get isValidHex => _isValidHex;

  void initializeColors(List<Color> colors) {
    _selectedColors.clear();
    _controllers.clear();
    _isValidHex.clear();

    for (int i = 0; i < colors.length; i++) {
      _selectedColors.add(colors[i]);
      _controllers.add(TextEditingController());
      _isValidHex.add(true);
    }
    notifyListeners();
  }

  void updateColor(int index, Color color) {
    if (index < _selectedColors.length) {
      _selectedColors[index] = color;
      _controllers[index].text = _colorToHex(color);
      _isValidHex[index] = true;
      notifyListeners();
    }
  }

  void updateHexValue(int index, String hexValue) {
    if (index < _isValidHex.length) {
      _isValidHex[index] = _isValidHexCode(hexValue);
      if (_isValidHex[index] && hexValue.isNotEmpty) {
        _selectedColors[index] = _hexToColor(hexValue);
      }
      notifyListeners();
    }
  }

  bool _isValidHexCode(String hex) {
    if (hex.isEmpty) return true;
    return RegExp(r'^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$').hasMatch(hex);
  }

  Color _hexToColor(String hex) {
    if (hex.isEmpty) return Colors.transparent;
    hex = hex.replaceAll('#', '');
    if (hex.length == 3) {
      hex = hex.split('').map((char) => char + char).join();
    }
    return Color(int.parse('FF$hex', radix: 16));
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
