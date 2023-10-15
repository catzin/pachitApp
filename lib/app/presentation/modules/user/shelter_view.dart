import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/global_controllers/global_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/shelter_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/widgets/profile_content.dart';

import '../../routes/routes.dart';
import '../../shared/pet_card.dart';
import '../../theme/colors.dart';
import 'reminders_view.dart';

class ShelterView extends StatelessWidget {
  ShelterView({super.key});

  final shelterController = Get.find<ShelterController>();
  

  @override
  Widget build(BuildContext context) {
    return 
      DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            shelterController.data.fotoPortada),
                        fit: BoxFit.cover),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 70,
                        left: 20,
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                            child: const Icon(
                              LineIcons.arrowLeft,
                              size: 40,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: TabBar(
        
                            tabs:  [
                               const Tab(
                                icon: Icon(
                                  Icons.home,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                text: "Info",
                              ),
                              
                                const Tab(
                                  icon: Icon(
                                    Icons.pets,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  text: "Mascotas",
                                ) ,
                              
                              
                              Obx(() => shelterController.isMyShelter.value ?
                                 const Tab(
                                    icon: Icon(
                                      Icons.remember_me_outlined,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    text: "Recordatorios",
                                  ) : Container(),
                              ) 
                              
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ProfileContent(
                              shelterController: shelterController,
                            ),
                            ShelterPets(shelterController: shelterController),
                            Reminders()
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        )),
      
    );
  }
}




class ShelterPets extends StatelessWidget {
  ShelterPets({
    super.key,
    required this.shelterController,
  });

  final ShelterController shelterController;
  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 20),
      child: Obx(
        () => shelterController.isLoading.value
            ? SpinKitCircle(
                color: HexColor(AppColors.primaryOrange),
                size: 80.0)
            : FadeInLeft(
                child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount:
                      shelterController.petList.length,
                  itemBuilder:
                      (BuildContext context, int index) {
                    final pet =
                        shelterController.petList[index];
                    return InkWell(
                      onTap: () {
                        
                        Get.toNamed(Routes.petProfile,arguments: pet);
                      },
                      onLongPress: () async {
                        if (shelterController.isMyShelter.value) {
                          final result = await showConfirmationDialog(
                              context: context,
                              title: 'Gestionar',
                              actions: const [
                                AlertDialogAction(key: 0, label: 'Ver Solicitudes'),
                                AlertDialogAction(key: 1, label: 'Agregar gasto'),
                            ],
                          );

                         switch(result){

                          case 1: Get.toNamed(Routes.incidence, arguments: pet.id) ;break;

                         }
                        }
                      },
                      child: Obx(() =>
                        PetCard(
                          image: pet.mascotaImgs[0].path,
                          petName: pet.nombre,
                          petSex: pet.sexo,
                          petType: pet
                              .tipoMascotaIdtipoMascota
                              .idtipoMascota,
                          showStatus: globalController.isShelter.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
