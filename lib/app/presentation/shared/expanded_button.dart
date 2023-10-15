import 'package:flutter/material.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';
import 'package:hexcolor/hexcolor.dart';
class ExpandedButton extends StatelessWidget {
  const ExpandedButton(
    {
    super.key, 
    required this.text,
    required this.color, 
    required this.textMode, 
    required this.action,

    });
  final bool textMode;
  final Text text;
  final String color;
  final  Function() action;


  @override
  Widget build(BuildContext context) {
    const padding  = EdgeInsets.symmetric(horizontal: 0,vertical: 12);
    const textButton = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

    return Row(
      children: [
        textMode ? 
        Expanded(
          child: TextButton(
          onPressed: action,
          child: text,
        )
        )
        :
        Expanded(
          child: ElevatedButton(
             
             onPressed:action,
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor(color),
                foregroundColor:  color == AppColors.primaryGray ? Colors.black : HexColor(AppColors.white),
                textStyle: textButton,
                padding: padding,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: text,
            ),
          )
          
      ],
    );
  }
}