import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';

import '../../../routes/routes.dart';
import '../../../shared/text_app.dart';
import '../../../theme/colors.dart';

class Advice extends StatelessWidget {
  const Advice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
      
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const TextApp(text: "Administra tus rescates con pachitApp", fontSize: 20.0, weight: FontWeight.bold, color: Colors.black),
                    const TextApp(text: "Para unite es necesario conocer un poco de tu organización.", fontSize: 16.0, weight: FontWeight.w500, color: Colors.black, align: TextAlign.center,),
                    Image.asset('lib/app/presentation/assets/girlDog.png'),
                    const TextApp(text: "A continuación requerimos que llenes una solicitud.", fontSize: 20.0, weight: FontWeight.w500, color: Colors.black, align: TextAlign.center,),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextApp(text: "¡Hagámoslo!", fontSize: 20.0, weight: FontWeight.bold, color: Colors.black),
                    const SizedBox(height: 10,),
                    Container(
                      width: 60,
                      height: 60,
                      decoration:BoxDecoration(
                        color: HexColor(AppColors.primaryOrange),
                        shape: BoxShape.circle
                      ),

                      child: InkWell(
                        onTap: () => Get.offAllNamed(Routes.peticion),
                        borderRadius:BorderRadius.circular(12),
                        child: const Icon(LineIcons.arrowRight),
                      )
                    ),
                  ],
                ),
              )
            ],
           
          ),
        ),
      ),
    );
  }
}