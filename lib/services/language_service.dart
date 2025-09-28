import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modern_grocery/localization/app_localizations.dart';

class LanguageService extends ChangeNotifier {
  static const String _languageKey = 'selected_language_code';
  String _currentLanguage = 'en';

  String get currentLanguage => _currentLanguage;

  LanguageService() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(_languageKey) ?? 'en';
    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
      notifyListeners();
    }
  }

  String getString(String key) {
    return AppLocalizations.getString(key, _currentLanguage);
  }

  Locale get locale {
    switch (_currentLanguage) {
      case 'hi':
        return const Locale('hi', 'IN');
      case 'ml':
        return const Locale('ml', 'IN');
      case 'ar':
        return const Locale('ar', 'SA');

      default:
        return const Locale('en', 'US');
    }
  }
}

