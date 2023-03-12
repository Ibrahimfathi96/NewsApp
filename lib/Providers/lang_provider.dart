import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier{
  String currentLang = 'ar';
  void getLang(String newLocale) async {
    final pref = await SharedPreferences.getInstance();
    if (currentLang == newLocale) return;
    currentLang = newLocale;
    pref.setString('lang', currentLang);
    notifyListeners();
  }
}