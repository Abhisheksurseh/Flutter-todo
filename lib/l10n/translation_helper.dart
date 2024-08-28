// import 'dart:convert';
// import 'package:flutter/services.dart';

// class TranslationHelper {
//   final Locale locale;

//   TranslationHelper(this.locale);

//   static TranslationHelper of(BuildContext context) {
//     return Localizations.of<TranslationHelper>(context, TranslationHelper)!;
//   }

//   Map<String, String> _localizedStrings = {};

//   Future<bool> load() async {
//     String jsonString = await rootBundle.loadString('lib/l10n/app_${locale.languageCode}.json');
//     Map<String, dynamic> jsonMap = json.decode(jsonString);

//     _localizedStrings = jsonMap.map((key, value) {
//       return MapEntry(key, value.toString());
//     });

//     return true;
//   }

//   String translate(String key) {
//     return _localizedStrings[key] ?? key;
//   }
// }
