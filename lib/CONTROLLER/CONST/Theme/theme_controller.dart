import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDark = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  void toggleTheme() async {
    isDark.value = !isDark.value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", isDark.value);
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool("isDark") ?? true;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }
}
