// lib/core/constants/app_color.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../theme/theme_controller.dart';

class AppColor {

  static const Color primaryGreen = Color(0xFF3d4e3c);
  static const Color green = Color(0xFF4C7755);
  static const Color success = Color(0xFF28A745);
  static const Color error = Color(0xFFDC3545);
  static const Color warning = Color(0xFFFFC107);
  static const Color orange = Colors.orange;
  static const Color blue = Colors.blue;
  static const Color amber = Colors.amber;
  static const Color transparent = Colors.transparent;


  static bool get _isDark => Get.find<ThemeController>().isDarkMode.value;
  static Color get background => _isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FC);
  static Color get white => _isDark ? const Color(0xFF1E1E1E) : Colors.white;
  static Color get black => _isDark ? Colors.white : const Color(0xFF1A1A2E);
  static Color get grey => _isDark ? const Color(0xFF9E9E9E) : const Color(0xFF6C757D);
  static Color get scaffoldBackground => _isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FC);
  static Color get cardColor => _isDark ? const Color(0xFF1E1E1E) : Colors.white;
  static Color get fillColor => _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF1F3F5);

  static Color get black87 => _isDark ? Colors.white70 : Colors.black87;
  static Color get black12 => _isDark ? Colors.white12 : Colors.black12;
  static Color get primaryGrey => _isDark ? Colors.grey.shade400 : Colors.grey;
  static Color get greyText => _isDark ? const Color(0xFFB0B0B0) : const Color(0xFF8E8E8E);
  static Color get lightGrey => _isDark ? const Color(0xFF3C3C3C) : const Color(0xFFE9ECEF);
  static Color get creamLight => _isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFFEBD2);

  static Color get primary => _isDark ? primaryGreen : const Color(0xFF0066FF);
  static Color get secondary => _isDark ? primaryGreen : const Color(0xFF00C8FF);
}