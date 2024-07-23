import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  static TextStyle _regular(double size, [Color? color]) => GoogleFonts.barlow(
        textStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: color,
          fontSize: size,
        ),
      );

  static TextStyle _medium(double size, [Color? color, double? height]) =>
      GoogleFonts.barlow(
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: size,
          color: color,
          height: height,
        ),
      );

  static TextStyle _bold(double size, [Color? color, double? height]) =>
      GoogleFonts.barlow(
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: size,
          color: color,
          height: height,
        ),
      );

  static TextStyle medium16([Color? color]) => _medium(16, color);

  static TextStyle medium18([Color? color]) => _medium(18, color);

  static TextStyle medium20([Color? color]) => _medium(20, color);

  static TextStyle medium22([Color? color]) => _medium(22, color);

  static TextStyle regular16([Color? color]) => _regular(16, color);

  static TextStyle regular18([Color? color]) => _regular(18, color);

  static TextStyle regular20([Color? color]) => _regular(20, color);

  static TextStyle bold16([Color? color]) => _bold(16, color);

  static TextStyle bold18([Color? color]) => _bold(18, color);

  static TextStyle bold20([Color? color]) => _bold(20, color);

  static TextStyle bold22([Color? color]) => _bold(22, color);
}
