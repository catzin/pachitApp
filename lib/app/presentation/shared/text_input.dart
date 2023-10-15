import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../theme/colors.dart';


InputDecoration setInputStyles(String hint, Icon icon) {
    return InputDecoration(
      filled: true,
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: icon,
      ),
      border: InputBorder.none,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      fillColor: HexColor(AppColors.blueLight).withOpacity(0.4),
    );
  }