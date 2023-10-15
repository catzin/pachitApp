import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/modules/splash/controllers/splash_controller.dart';
import '../../theme/colors.dart';


class SplashView extends StatelessWidget {
  SplashView({super.key});

  final splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: HexColor(AppColors.secondaryLight),
      body: const Center(
        child: Image(image: AssetImage('lib/app/presentation/assets/logo.png')),
        ),
    );
  }
}