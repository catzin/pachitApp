import 'package:flutter/material.dart';

class BrandBar extends StatelessWidget {
  const BrandBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Image.asset('lib/app/presentation/assets/slogan.png'),
          const Icon(Icons.pets)
        ],
      ),
    );
  }
}