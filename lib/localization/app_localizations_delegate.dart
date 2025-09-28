import 'package:flutter/material.dart';
import 'package:modern_grocery/localization/app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'ml', 'ar', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations.instance;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class AppLocalizations {
  static AppLocalizations? _instance;
  static String _currentLanguage = 'en';

  static AppLocalizations get instance {
    _instance ??= AppLocalizations._();
    return _instance!;
  }

  AppLocalizations._();

  static void setLanguage(String languageCode) {
    _currentLanguage = languageCode;
  }

  String getString(String key, [String? currentLanguage]) {
    final lang = currentLanguage ?? _currentLanguage;

    return '[$lang] $key';
  }
}
