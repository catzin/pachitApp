import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextApp extends StatelessWidget {
  const TextApp({
    super.key,
    required this.text,
    required this.fontSize,
    required this.weight,
    required this.color,
    this.align
  });
  
  final String text;
  final TextAlign ? align;
  final double fontSize;
  final FontWeight weight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexSans(
        fontSize: fontSize,
        fontWeight: weight,
        color: color
      ),
      textAlign: align,
    );
  }
}
