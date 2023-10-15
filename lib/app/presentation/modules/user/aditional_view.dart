import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/new_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/widgets/upload_layout.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import '../../shared/text_app.dart';
import '../../theme/colors.dart';

class AditionalView extends StatelessWidget {
  AditionalView({super.key});

  final newViewController = Get.find<NewViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fotos"),
        backgroundColor: HexColor(AppColors.primaryOrange),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const UploadTitle(),      
              const SizedBox(
                height: 20,
              ),
              const UploadLayout(),
              const SizedBox(
                height: 20,
              ),

              const CaractTitle(),

                const SizedBox(height: 5,),

                 SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: MyChipList()
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CaractTitle extends StatelessWidget {
  const CaractTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextApp(
                text: 'Caracteristicas',
                fontSize: 30,
                weight: FontWeight.w500,
                color: Colors.black),
            TextApp(
                text: 'Elige al menos una caracteristica que posea la mascota.',
                fontSize: 18,
                weight: FontWeight.bold,
                color: Colors.grey),
          ],
      );
  }
}

class UploadTitle extends StatelessWidget {
  const UploadTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextApp(
                text: 'Sube',
                fontSize: 30,
                weight: FontWeight.w500,
                color: Colors.black),
            TextApp(
                text: 'Las 3 mejores fotos de la mascota',
                fontSize: 18,
                weight: FontWeight.bold,
                color: Colors.grey),
          ],
        ),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.amberAccent),
          child: const Center(
            child: Icon(
              LineIcons.arrowCircleUp,
              size: 35,
            ),
          ),
        )
      ],
    );
  }
}
class MyChipList extends StatelessWidget {
  final controller = Get.find<NewViewController>();

  MyChipList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[
        Obx(() => Wrap(
              children: controller.caracts.map((chip) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    selectedColor: HexColor(AppColors.primaryOrange).withOpacity(0.5),
                    label: Text(chip.nombre),
                    selected: controller.selectedChips.contains(chip),
                    onSelected: (selected) {
                      controller.toggleChip(chip);
                    },
                  ),
                );
              }).toList(),
            )),
            const SizedBox(height: 30),

         Obx(() => controller.loadingPet.value ? const Center(child: CircularProgressIndicator(),) :
            ExpandedButton(
            text: const Text("Registrar"),
            color: AppColors.primaryOrange,
            textMode: false,
            action:()async =>  controller.createNewPet(),
                 ),
         )

      ],
    );
  }


}