import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/new_controller.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import '../../routes/routes.dart';
import '../../shared/expanded_button.dart';
import '../../theme/colors.dart';
import 'widgets/new_form.dart';


class NewView extends StatelessWidget {
  NewView({super.key});
  final newViewController = Get.find<NewViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Nueva mascota"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TextApp(
                          text: 'Registra',
                          fontSize: 30,
                          weight: FontWeight.w500,
                          color: Colors.black),
                      TextApp(
                          text: 'Una nueva mascota',
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
                        LineIcons.identificationCard,
                        size: 35,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextApp(
                      text: 'Información',
                      fontSize: 30,
                      weight: FontWeight.w500,
                      color: Colors.black),
                  TextApp(
                      text: 'Informacion básica de la mascota',
                      fontSize: 18,
                      weight: FontWeight.bold,
                      color: Colors.grey),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              NewForm(newViewController: newViewController),
              const SizedBox(
                height: 40,
              ),

              ExpandedButton(
                text: const Text("Continuar"),
                color: AppColors.primaryOrange,
                textMode: false,
                action: () {
                  Get.toNamed(Routes.newPetPhotos);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

