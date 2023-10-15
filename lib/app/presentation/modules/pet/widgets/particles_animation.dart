
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../../../theme/colors.dart';


class CircularParticleScreen extends StatelessWidget {
  const CircularParticleScreen({super.key});


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return  Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: FadeInRight(
              child: CachedNetworkImage(
                imageUrl:'https://pachstorage.s3.amazonaws.com/16852165958391685216593202.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              key: UniqueKey(),
              child: CircularParticle(
                awayRadius: 80,
                numberOfParticles: 200,
                speedOfParticles: 1,
                height: screenHeight,
                width: screenWidth,
                onTapAnimation: true,
                particleColor: Colors.transparent,
                awayAnimationDuration: const Duration(milliseconds: 600),
                maxParticleSize: 8,
                isRandSize: true,
                isRandomColor: true,
                randColorList: [
                  Colors.red.withAlpha(210),
                  Colors.white.withAlpha(210),
                  Colors.yellow.withAlpha(210),
                  Colors.green.withAlpha(210)
                ],
                awayAnimationCurve: Curves.easeInOutBack,
                enableHover: true,
                hoverColor: Colors.white,
                hoverRadius: 90,
                connectDots: true, // not recommended
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 300,
              color: HexColor(AppColors.primaryOrange),

              child: const TextApp(
                text: 'DarKi',
                fontSize: 30,
                weight: FontWeight.w500,
                color: Colors.black,
                align: TextAlign.center,
              ),
            )
          ),
         
        ],
    );
  
  }
}
