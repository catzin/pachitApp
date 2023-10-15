import 'package:flutter/material.dart';

import 'text_app.dart';

class TitleSection extends StatelessWidget {

  final String title;
  final String subTitle;
  final IconData icon;
  const TitleSection({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
                text: title,
                fontSize: 30,
                weight: FontWeight.w500,
                color: Colors.black),
            TextApp(
                text: subTitle,
                fontSize: 18,
                weight: FontWeight.bold,
                color: Colors.grey),
          ],
        ),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.amberAccent),
          child: Center(
            child: Icon(
              icon,
              size: 35,
            ),
          ),
        )
      ],
    );
  }
}
