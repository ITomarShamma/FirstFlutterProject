// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';

// // Add your supported languages and their translations here
// Map<String, Map<String, String>> localizedValues = {
//   'en': {
//     'hello': 'Hello',
//     'settings': 'Settings',
//     'language': 'Language',
//     'app_theme': 'App Theme',
//     'dark': 'Dark',
//     'light': 'Light',
//   },
//   'ar': {
//     'hello': 'مرحبا',
//     'settings': 'الإعدادات',
//     'language': 'اللغة',
//     'app_theme': 'موضوع التطبيق',
//     'dark': 'داكن',
//     'light': 'فاتح',
//   },
// };

// class LocalizationModel extends Model {
//   Locale _locale = Locale('en');
//   Locale get locale => _locale;

//   void changeLanguage(String languageCode) {
//     _locale = Locale(languageCode);
//     notifyListeners();
//   }

//   String translate(String key) {
//     return localizedValues[_locale.languageCode]?[key] ?? key;
//   }
// }
