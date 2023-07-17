import 'package:flutter/material.dart';

class MyColors {
  MyColors.light() {
    separator = _separatorLight;
    overlay = _overlayLight;
    labelPrimary = _labelPrimaryLight;
    labelSecondary = _labelSecondaryLight;
    labelTertiary = _labelTertiaryLight;
    labelDisable = _labelDisableLight;
    greyLight = _greyLightLight;
    primary = _primaryLight;
    secondary = _secondaryLight;
    elevated = _elevatedLight;
  }

  MyColors.dark() {
    separator = _separatorDark;
    overlay = _overlayDark;
    labelPrimary = _labelPrimaryDark;
    labelSecondary = _labelSecondaryDark;
    labelTertiary = _labelTertiaryDark;
    labelDisable = _labelDisableDark;
    greyLight = _greyLightDark;
    primary = _primaryDark;
    secondary = _secondaryDark;
    elevated = _elevatedDark;
  }

  late Color separator;
  static const Color _separatorLight = Color(0x33000000);
  static const Color _separatorDark = Color(0x33FFFFFF);

  late Color overlay;
  static const Color _overlayLight = Color(0x0F000000);
  static const Color _overlayDark = Color(0x52000000);

  late Color labelPrimary;
  static const Color _labelPrimaryLight = Color(0xFF000000);
  static const Color _labelPrimaryDark = Color(0xFFFFFFFF);

  late Color labelSecondary;
  static const Color _labelSecondaryLight = Color(0x99000000);
  static const Color _labelSecondaryDark = Color(0x99FFFFFF);

  late Color labelTertiary;
  static const Color _labelTertiaryLight = Color(0x4D000000);
  static const Color _labelTertiaryDark = Color(0x66FFFFFF);

  late Color labelDisable;
  static const Color _labelDisableLight = Color(0x26000000);
  static const Color _labelDisableDark = Color(0x26FFFFFF);

  final Color red = const Color(0xFFFF3B30);

  final Color purple = const Color(0xFF793CD8);

  final Color green = const Color(0xFF34C759);

  final Color blue = const Color(0xFF007AFF);

  final Color grey = const Color(0xFF8E8E93);

  late Color greyLight;
  static const Color _greyLightLight = Color(0xFFD1D1D6);
  static const Color _greyLightDark = Color(0xFF48484A);

  final Color white = const Color(0xFFFFFFFF);

  late Color primary;
  static const Color _primaryLight = Color(0xFFF7F6F2);
  static const Color _primaryDark = Color(0xFF161618);

  late Color secondary;
  static const Color _secondaryLight = Color(0xFFFFFFFF);
  static const Color _secondaryDark = Color(0xFF252528);

  late Color elevated;
  static const Color _elevatedLight = Color(0xFFFFFFFF);
  static const Color _elevatedDark = Color(0xFF3C3C3F);
}
