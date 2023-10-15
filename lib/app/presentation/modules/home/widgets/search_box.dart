import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../theme/colors.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: '¿Buscas a alguien?',
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: HexColor(AppColors.primaryGray),
          filled: true,
          border: InputBorder.none),
    );
  }
}

