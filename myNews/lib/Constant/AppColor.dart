import 'package:flutter/material.dart';
class AppColor {
  static const Color AppBAr_BAR_END = Color(0xFF85C1E9);
  static const Color AppBAr_BAR_BEGIN = Color(0xFF3498DB);

  static const Color STATUS_BAR_COLOR = Color(0xFF3498DB);
  static const Color TITLE_BAR_COLOR = Color(0xFF4D1544);
  static const Color ACCENT_COLOR = Color(0xFF3498DB);
  static const Color ACCENT_COLOR_unselect = Color(0xFF6c6b6b);
  static const Color SCREEN_BG = Color(0xFFffffff);
  static const Color DIVIDER_COLOR = Color(0xFFBDBDBD);
  static const Color INTRO_TEXT_COLOR = Color(0xFF979797);
  static const Color SELECTED_DOT_COLOR = Color(0xFF4D1544);
  static const Color TEXT_COLOR = Color(0xFF85C1E9);
  static const Color SELECTED_ITEM_BG = Color(0x1De95737);
  static const Color MENU_ICON_COLOR = Color(0xFF4D1544);
  static const Color APP_GRAY = Color(0xFF9E9E9E);
  static const Color BOTTOM_NAVIGATION_SELECTED_COLOR = Color(0xFFffffff);
  static const Color TRANSPARENT_FLOATING_BG_COLOR = Color(0xBA4D1544);
  static const Color PROFILE_TEXT_COLOR = Color(0xFFAFAFAF);
  static const Color SETTINGS_TITLE_COLOR = Color(0xFF4D1544);
  static const Color SELECTED_LANGUAGE_COLOR = Color(0xFFB59EB2);
  static const Color COMMENT_DESCRIPTION_COLOR = Color(0xFF484848);
  static const Color COMMENT_BOX_COLOR = Color(0xFFEEF3FA);
  static const Color CARD_BG = Color(0xFFfbfbfc);
  static const Color LIGHT_BLUE = Color(0xFF85C1E9);
  static const Color DARK_BLUE = Color(0xFF3498DB);
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
