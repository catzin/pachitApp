import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/modules/pet/controllers/pet_profileController.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';
import 'widgets/pet_slider.dart';

class PetGallery extends StatelessWidget {
  PetGallery({super.key});
  final petProfileController = Get.find<PetProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const TextApp(
          text: "Galeria",
          fontSize: 20,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/app/presentation/assets/petBack.jpg'),
                fit: BoxFit.cover)),
        child: Obx(
          () => petProfileController.loadingImages.value
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.orangeAccent,),
                )
              : Align(
                  alignment: Alignment.center,
                  child: PetSlider(),
                ),
        ),
      ),
    );
  }
}
