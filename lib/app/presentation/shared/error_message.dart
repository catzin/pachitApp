import 'package:flutter/material.dart';
import 'text_app.dart';

class ErrorMessage extends StatelessWidget {
  final String principal;
  final String message;
  final double principalSize;
  final double messageSize;
  final double imageWidth;
  final double imageHeight;
  const ErrorMessage({super.key, required this.principal, required this.message, required this.principalSize, required this.messageSize, required this.imageWidth, required this.imageHeight});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
           children: [
             Expanded(
              flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextApp(text: principal, fontSize: principalSize, weight: FontWeight.w500, color: Colors.red, align: TextAlign.center,),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset('lib/app/presentation/assets/cry.png',width: imageWidth, height: imageHeight,),
                    const SizedBox(
                      height: 30,
                    ),
                
                    TextApp(text: message, fontSize: messageSize, weight: FontWeight.w500, color: Colors.black, align: TextAlign.center,),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
            )
           ],
          ),
        );
  }
}