import 'package:flutter/material.dart';
import 'package:petto_app/config/theme/app_theme.dart';
import 'package:petto_app/utils/local_storage.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  ThemeData _theme = AppTheme.lightTheme();

  ThemeProvider() {
    _loadTheme();
  }

  _loadTheme() async {
    final themePrefs = LocalStorage.prefs.getBool('isDarkMode');
    if (themePrefs != null) {
      _isDarkMode = themePrefs;
      _theme = (_isDarkMode) ? AppTheme.darkTheme() : AppTheme.lightTheme();
    }
  }

  Future<void> _saveTheme(bool isDarkMode) async {
    final themePrefs = LocalStorage.prefs;
    await themePrefs.setBool('isDarkMode', isDarkMode);
  }

  void changeTheme() {
    if (_isDarkMode == true) {
      _isDarkMode = false;
      _theme = AppTheme.lightTheme();
    } else if (_isDarkMode == false) {
      _isDarkMode = true;
      _theme = AppTheme.darkTheme();
    }
    _saveTheme(_isDarkMode);
    notifyListeners();
  }

  ThemeData get theme => _theme;
}
