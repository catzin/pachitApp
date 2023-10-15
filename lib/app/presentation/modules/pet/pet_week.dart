import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../theme/colors.dart';
import 'controllers/pet_weekController.dart';
import 'widgets/particles_animation.dart';

class PetWeek extends StatelessWidget {

  final petWeekController = Get.find<PetWeekController>();
  PetWeek({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Mascota favorita"),
      ),
      body: Obx(() =>  petWeekController.isReady.value ? const CircularParticleScreen() : const Center(child: CircularProgressIndicator(color: Colors.orangeAccent,),)) ,
    );
  }
}