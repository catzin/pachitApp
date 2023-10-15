import 'package:flutter/material.dart';

class Heading extends StatelessWidget {

  const Heading({super.key, required this.principalText, required this.secondaryText});
  final String principalText;
  final String secondaryText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              principalText,
              style: const  TextStyle(
                fontSize: 25, 
                fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 10,),
            Text(
              secondaryText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )
          ],
        
      ),
    );
  }
}
