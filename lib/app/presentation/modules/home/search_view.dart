import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/search_pet_controller.dart';
import 'package:pachitaapp/app/presentation/shared/tittle_section.dart';
import '../../../domain/models/pets_user.dart';
import '../../routes/routes.dart';
import '../../theme/colors.dart';


class SearchView extends StatelessWidget {
  SearchView({super.key});

  final searchController = Get.find<SearchPetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Buscar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TitleSection(
                title: 'Buscar incidencias',
                subTitle: 'Por mascota',
              icon: LineIcons.dog,
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(()=>
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  label: Text("Mascota"),
                  hintText: 'Mascota',
                  border: OutlineInputBorder(),
                ),
                items: searchController.petList.map((PetU pet) {
                  return DropdownMenuItem<int>(
                    value: pet.id,
                    child: Text(pet.nombre),
                  );
                }).toList(),
                onChanged: (int? value) {
                  searchController.selectedPet.value = value!;
                  Get.toNamed(Routes.historial, arguments: value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
