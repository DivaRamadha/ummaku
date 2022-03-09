import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ummaku/style/color.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    textTheme: const TextTheme(
      caption: TextStyle(
        color: Colors.black54,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
      headline6: TextStyle(color: Colors.black54),
      headline5: TextStyle(color: Colors.black54),
      headline4: TextStyle(color: Colors.black54),
      headline3: TextStyle(color: Colors.black54),
      bodyText1: TextStyle(color: Colors.black54),
      bodyText2: TextStyle(color: Colors.black54),
      button: TextStyle(color: Colors.black54),
      headline1: TextStyle(color: Colors.black54),
      headline2: TextStyle(color: Colors.black54),
      overline: TextStyle(color: Colors.black54),
      subtitle1: TextStyle(
        color: Colors.grey,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
      subtitle2: TextStyle(
        color: Colors.grey,
        fontFamily: 'Poppins',
        fontSize: 10,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 1.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    dividerTheme: const DividerThemeData(thickness: 1.0),
    primaryColor: primaryColor,
    dividerColor: secondaryColor,
    brightness: Brightness.light,
    disabledColor: Colors.grey[500],
    primaryColorBrightness: Brightness.light,
    buttonColor: secondaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 1.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedIconTheme: IconThemeData(
        color: Colors.grey[500],
      ),
      selectedIconTheme: const IconThemeData(
        color: secondaryColor,
      ),
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black54,
    buttonColor: primaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 1.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedIconTheme: IconThemeData(
        color: Colors.grey[500],
      ),
      selectedIconTheme: const IconThemeData(
        color: primaryColor,
      ),
    ),
  );
}

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
