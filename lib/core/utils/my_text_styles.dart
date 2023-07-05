import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/utils/my_colors.dart';

abstract class MyTextStyles {
  static final lagreTitle = GoogleFonts.roboto(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: MyColors.labelPrimary,
    height: 38/32,
  );
  static final title = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: MyColors.labelPrimary,
    height: 32/20,
  );
  static final button = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: MyColors.labelPrimary,
    height: 14/24,
  );
  static final body = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: MyColors.labelPrimary,
    height: 20/16,
  );
  static final subhead = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: MyColors.labelPrimary,
    height: 20/14,
  );
}
