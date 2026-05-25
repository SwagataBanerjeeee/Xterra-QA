import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static const String _fontFamily = 'Inter';

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brand),
    appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    fontFamily: _fontFamily,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.brand,
      brightness: Brightness.dark,
    ),
  );
}
