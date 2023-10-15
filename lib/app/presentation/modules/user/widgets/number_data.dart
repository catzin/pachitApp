import 'package:flutter/material.dart' show BuildContext, Colors, Column, FontWeight, MainAxisAlignment, Row, StatelessWidget, Widget;
import '../../../shared/text_app.dart';

class NumberData extends StatelessWidget {
  const NumberData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children:  const [

             TextApp(
                text:'Mascotas', 
                fontSize: 18,
                weight: FontWeight.bold,
                color: Colors.orangeAccent, 
                
              ),

              TextApp(
                text:'100', 
                fontSize: 18,
                weight: FontWeight.bold,
                color: Colors.black, 
                
              ),


          ],
        ),
       
        Column(
          children:const [

             TextApp(
                text:'Registrada en', 
                fontSize: 16,
                weight: FontWeight.bold,
                color: Colors.orangeAccent, 
                
              ),

              TextApp(
                text:'22/07/2005', 
                fontSize: 16,
                weight: FontWeight.bold,
                color: Colors.black, 
                
              ),

            
          ],
        )
        
      ],
    );
  }
}


