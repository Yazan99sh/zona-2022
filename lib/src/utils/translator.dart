import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class Translator
{
  static Future<String> translateService(String word,BuildContext context) async {
    final Locale appLocale = Localizations.localeOf(context);
    var reg = RegExp(r'[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]');
    if (reg.hasMatch(word) && appLocale.toString() == 'ar') {
      return word;
    }
    final translator = GoogleTranslator();
    var translation = await translator.translate(word, to: appLocale.toString());
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print('source ${translation.source} translated to ${translation.text}');
    print('source ${translation.sourceLanguage} target ${translation.targetLanguage}');
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');

    return translation.text;
  }
}