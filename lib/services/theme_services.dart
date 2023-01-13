import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage box = GetStorage();
  final String key = 'isDarkeThem';
  saveThemToBox(bool isDarkeThem) => box.write(key, isDarkeThem);
  bool loadThemFromBox() => box.read<bool>(key) ?? false;

  ThemeMode get Theme => loadThemFromBox() ? ThemeMode.dark : ThemeMode.light;
  void SwitchTheme() {
    Get.changeThemeMode(loadThemFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemToBox(!loadThemFromBox());
  }
}
