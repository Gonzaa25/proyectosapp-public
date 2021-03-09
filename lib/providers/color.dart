import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorThemeProvider extends ChangeNotifier {
  MaterialColor? _color = Colors.green;
  MaterialColor? get appcolor => _color;

  void changeAppColor(MaterialColor? newColor) {
    _color = newColor;
    notifyListeners();
  }
}
