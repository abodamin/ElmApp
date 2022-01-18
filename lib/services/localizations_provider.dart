import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;

  void setLocale(Locale newLocale) {
    if (!L10n.support.contains(newLocale)) return;
    _locale = newLocale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}

class L10n {
  static const List<Locale> support = [Locale("en"), Locale("ar")];
}
