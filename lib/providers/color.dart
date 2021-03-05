import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorThemeProvider extends ChangeNotifier {
  MaterialColor? _color = Colors.teal;
  MaterialColor? get appcolor => _color;

  void changeAppColor() {
    List colors = [
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.blueGrey,
      Colors.teal,
      Colors.amber
    ];
    Random random = new Random();
    int index = random.nextInt(7);
    _color = colors[index];
    notifyListeners();
  }
}
