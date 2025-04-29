import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
  );

  bool _isDark;

  AppTheme(this._isDark);

  bool get isDark => _isDark;

  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }
}