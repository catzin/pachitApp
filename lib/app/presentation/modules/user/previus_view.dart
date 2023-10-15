import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../theme/colors.dart';
import 'controllers/previus_pet.controller.dart';

class PreviusView extends StatelessWidget {
  PreviusView({super.key});
  final preeviusController = Get.find<PreviusPetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Documentos"),
        backgroundColor: HexColor(AppColors.primaryOrange),
      ),
      body: Column(
        children: [],
      )
    );
  }
}