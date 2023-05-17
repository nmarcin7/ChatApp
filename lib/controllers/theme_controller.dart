import 'package:flutter/foundation.dart';

class ThemeController extends ChangeNotifier {
  bool toggleTheme = false;

  void toggleThemeUi() {
    toggleTheme = !toggleTheme;
    notifyListeners();
  }
}
