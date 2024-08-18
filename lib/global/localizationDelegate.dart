// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'localizationModel.dart';

// class AppLocalizations {
//   final Locale locale;

//   AppLocalizations(this.locale);

//   static AppLocalizations of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
//   }

//   String translate(String key) {
//     return localizedValues[locale.languageCode]?[key] ?? key;
//   }
// }

// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const AppLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) {
//     return ['en', 'ar'].contains(locale.languageCode);
//   }

//   @override
//   Future<AppLocalizations> load(Locale locale) {
//     return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
//   }

//   @override
//   bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
//     return false;
//   }
// }
