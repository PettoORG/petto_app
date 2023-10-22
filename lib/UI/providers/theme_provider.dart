import 'package:flutter/material.dart';
import 'package:petto_app/config/theme/app_theme.dart';
import 'package:petto_app/utils/local_storage.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  ThemeData _theme = AppTheme.lightTheme();

  loadTheme() async {
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
    } else {
      loadTheme();
    }
    _saveTheme(_isDarkMode);
    notifyListeners();
  }

  void changeHoverColor(Color color, bool event) {
    if (event == true) {
      color = theme.colorScheme.secondary;
    } else {
      color = theme.colorScheme.onBackground;
    }
  }

  ThemeData get theme => _theme;
  bool get isDarkMode => _isDarkMode;
}
