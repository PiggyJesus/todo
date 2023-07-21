import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyles {
  late final TextStyle lagreTitle;
  late final TextStyle title;
  late final TextStyle button;
  late final TextStyle body;
  late final TextStyle subhead;

  MyTextStyles(Color color) {
    lagreTitle = _lagreTitle.copyWith(color: color);
    title = _title.copyWith(color: color);
    button = _button.copyWith(color: color);
    body = _body.copyWith(color: color);
    subhead = _subhead.copyWith(color: color);
  }

  static final _lagreTitle = GoogleFonts.roboto(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 38 / 32,
  );
  static final _title = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 32 / 20,
  );
  static final _button = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 14 / 24,
  );
  static final _body = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 20 / 16,
  );
  static final _subhead = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
  );
}
