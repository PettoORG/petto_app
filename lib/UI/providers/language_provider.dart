import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petto_app/utils/utils.dart';

class LanguageProvider extends ChangeNotifier {
  String _language = Platform.localeName.substring(0, 2);
  String get language => _language;

  LanguageProvider() {
    logger.d('Device Language: $_language');
    _loadLanguage();
  }

  _loadLanguage() async {
    final languagePrefs = LocalStorage.prefs.getString('language');
    if (languagePrefs != null) {
      _language = languagePrefs;
      notifyListeners();
    }
  }

  Future<void> _saveLanguage(String language) async {
    final languagePrefs = LocalStorage.prefs;
    await languagePrefs.setString('language', language);
  }

  void changeLanguage(String newLanguage) {
    _language = newLanguage;
    _saveLanguage(_language);
    notifyListeners();
  }
}
