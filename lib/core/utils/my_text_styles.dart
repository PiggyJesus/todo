import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyles {
  late final TextStyle lagreTitle;
  late final TextStyle title;
  late final TextStyle button;
  late final TextStyle body;
  late final TextStyle subhead;

  MyTextStyles(Color color) {
    lagreTitle = GoogleFonts.roboto(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: color,
      height: 38 / 32,
    );
    title = GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: color,
      height: 32 / 20,
    );
    button = GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
      height: 14 / 24,
    );
    body = GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      height: 20 / 16,
    );
    subhead = GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color,
      height: 20 / 14,
    );
  }
}
