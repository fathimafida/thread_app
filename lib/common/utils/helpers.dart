import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void navigateTo(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

TextStyle applyGoogleFontToText(int text) {
  return GoogleFonts.getFont(
    'Mooli',
    textStyle: TextStyle(
      fontSize: text.toDouble(),
      fontWeight: FontWeight.bold,
    ),
  );
}
