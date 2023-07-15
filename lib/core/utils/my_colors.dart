import 'package:flutter/material.dart';

abstract class MyColors {
  static Color get separator =>
      ThemeMode.system == ThemeMode.light ? separatorLight : separatorDark;
  static const Color separatorLight = Color(0x33000000);
  static const Color separatorDark = Color(0x33FFFFFF);

  static Color get overlay =>
      ThemeMode.system == ThemeMode.light ? overlayLight : overlayDark;
  static const Color overlayLight = Color(0x0F000000);
  static const Color overlayDark = Color(0x52000000);



  static Color get labelPrimary => ThemeMode.system == ThemeMode.light
      ? labelPrimaryLight
      : labelPrimaryDark;
  static const Color labelPrimaryLight = Color(0xFF000000);
  static const Color labelPrimaryDark = Color(0xFFFFFFFF);

  static Color get labelSecondary => ThemeMode.system == ThemeMode.light
      ? labelSecondaryLight
      : labelSecondaryDark;
  static const Color labelSecondaryLight = Color(0x99000000);
  static const Color labelSecondaryDark = Color(0x99FFFFFF);

  static Color get labelTertiary => ThemeMode.system == ThemeMode.light
      ? labelTertiaryLight
      : labelTertiaryDark;
  static const Color labelTertiaryLight = Color(0x4D000000);
  static const Color labelTertiaryDark = Color(0x66FFFFFF);

  static Color get labelDisable => ThemeMode.system == ThemeMode.light
      ? labelDisableLight
      : labelDisableDark;
  static const Color labelDisableLight = Color(0x26000000);
  static const Color labelDisableDark = Color(0x26FFFFFF);



  static const Color red = Color(0xFFFF3B30);

  static const Color green = Color(0xFF34C759);

  static const Color blue = Color(0xFF007AFF);

  static const Color grey = Color(0xFF8E8E93);

  static Color get greyLight => ThemeMode.system == ThemeMode.light
      ? greyLightLight
      : greyLightDark;
  static const Color greyLightLight = Color(0xFFD1D1D6);
  static const Color greyLightDark = Color(0xFF48484A);

  static const Color white = Color(0xFFFFFFFF);



  static Color get primary => ThemeMode.system == ThemeMode.light
      ? primaryLight
      : primaryDark;
  static const Color primaryLight = Color(0xFFF7F6F2);
  static const Color primaryDark = Color(0xFF161618);

  static Color get secondary => ThemeMode.system == ThemeMode.light
      ? secondaryLight
      : secondaryDark;
  static const Color secondaryLight = Color(0xFFFFFFFF);
  static const Color secondaryDark = Color(0xFF252528);
  
  static Color get elevated => ThemeMode.system == ThemeMode.light
      ? elevatedLight
      : elevatedDark;
  static const Color elevatedLight = Color(0xFFFFFFFF);
  static const Color elevatedDark = Color(0xFF3C3C3F);
}
