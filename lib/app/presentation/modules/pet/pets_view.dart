import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/pet/controllers/pet_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';
import '../../routes/routes.dart';
import '../../shared/pet_card.dart';

class PetsView extends StatelessWidget {
  PetsView({super.key});

  final petController = Get.find<PetController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const TextApp(
                        text: 'Filtrar por',
                        fontSize: 20,
                        weight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TextApp(
                            text: 'Edad',
                            fontSize: 16,
                            weight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilterOption(
                                icon: LineIcons.paw,
                                label: 'Cachorros',
                                action: ()async{
                                  petController.getPetsByAge(1);
                                  Get.back();
                                }
                     
                              ),
                             const SizedBox(width: 8),
                              FilterOption(
                                icon: LineIcons.dog,
                                label: 'Jovenes',
                                action: ()async{
                                  petController.getPetsByAge(2);
                                  Get.back();
                                },
                        
                              ),
                              const SizedBox(width: 8),
                              FilterOption(
                                icon: LineIcons.dog,
                                label: 'Adultos',
                                action: ()async{

                                  petController.getPetsByAge(3);
                                  Get.back();

                                },
                               
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TextApp(
                            text: 'Nivel de actividad',
                            fontSize: 16,
                            weight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              FilterOption(
                                icon: LineIcons.dog,
                                label: 'Alto',
                                action: ()async{
                                  petController.getPetsByActivity(1);
                                  Get.back();

                                },
                              ),
                              const SizedBox(width: 8),
                              FilterOption(
                                icon: LineIcons.dog,
                                label: 'Medio',
                                action: ()async{
                                  petController.getPetsByActivity(2);
                                  Get.back();
                                },
                              ),
                              const SizedBox(width: 8),
                              FilterOption(
                                icon: LineIcons.dog,
                                label: 'Bajo',
                                action: ()async{
                                  petController.getPetsByActivity(3);
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          TextButton(
                            onPressed: ()async{
                              petController.resetFilters();
                              Get.back();
                            },
                            child: const Text("Reset"),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Text(
            // ignore: unrelated_type_equality_checks
            petController.type == "1"
                ? 'Listado de lomitos 🐕'
                : petController.type == "2"
                    ? 'Listado de michis 🐈'
                    : "Listado general 🐕🐱",
            style: GoogleFonts.ibmPlexSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Obx(
          () => petController.isLoading.value
              ? SpinKitCircle(
                  color: HexColor(AppColors.primaryOrange), size: 80.0)
              : FadeInRight(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0),
                    itemCount: petController.petList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final pet = petController.petList[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.petProfile, arguments: pet);
                        },
                        child: PetCard(
                          image: pet.mascotaImgs[0].path,
                          petName: pet.nombre,
                          petSex: pet.sexo,
                          petType: pet.tipoMascotaIdtipoMascota.idtipoMascota,
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

class FilterOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() action;

  const FilterOption({Key? key, required this.icon, required this.label, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      // onTap: () {

      //   print(action());
      //   // Lógica para aplicar el filtro correspondiente
      //   Navigator.of(context).pop(); // Cierra el Bottom Modal
      // },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: HexColor(AppColors.cancel)),
          const SizedBox(height: 8),
          TextApp(
              text: label,
              fontSize: 15,
              weight: FontWeight.bold,
              color: Colors.black)
        ],
      ),
    );
  }
}
