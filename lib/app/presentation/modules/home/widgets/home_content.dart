import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/modules/home/widgets/shelter_promo.dart';
import 'package:pachitaapp/app/presentation/modules/home/widgets/welcome_message.dart';

import '../../../global_controllers/global_controller.dart';
import '../../../routes/routes.dart';
import '../../../shared/pet_card.dart';
import '../../../shared/text_app.dart';
import '../../../theme/colors.dart';
import '../controllers/category_controller.dart';
import '../controllers/home_controller.dart';
import 'category_list.dart';
import 'favorite_pet.dart';

class HomeContent extends StatelessWidget {

  final homeController = Get.find<HomeController>();
  final globalController = Get.find<GlobalController>();
  final categoryController = Get.find<CategoryController>();

  HomeContent({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Obx(() => homeController.isLoading.value
            ? Center(
                child: SpinKitCircle(
                    color: HexColor(AppColors.primaryOrange), size: 80.0),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () => WelcomeMessage(
                          activeUser: homeController.activeUSer.value),
                    ),
                    // TextButton(
                    //   onPressed: ()async{
                    //     homeController.sendNotification();
                    //   },
                    //   child: Text("Notificacion"),
                    // ),
                    const SizedBox(height: 20),
                    FadeInRight(
                      child: const FavoritePet(),
                    ),
                    const SizedBox(height: 20),
                    CategoryList(
                      homeController: homeController,
                      categoryController: categoryController,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mascotas recomendadas 🐕',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                )),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.petsList, arguments: "0");
                              },
                              child: Text(
                                'Ver todo',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 300,
                          child: Obx(
                            () => homeController.loadingPets.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.orangeAccent,
                                    ),
                                  )
                                : FadeInLeft(
                                    child: ListView.builder(
                                      itemCount:
                                          homeController.petList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final pet =
                                            homeController.petList[index];
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.petProfile,
                                                arguments: pet);
                                          },
                                          child: PetCard(
                                            image: pet.mascotaImgs[0].path,
                                            petName: pet.nombre,
                                            petSex: pet.sexo,
                                            petType: 1,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nuevos refugios 🏠',
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Ver todos',
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 200,
                          child: Obx(
                            () => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.shelterList.length,
                              itemBuilder: (context, index) {
                                final shelter =
                                    homeController.shelterList[index];

                                return AspectRatio(
                                  aspectRatio: 1.7 / 2,
                                  child: InkWell(
                                    onTap: () => Get.toNamed(Routes.shelter,
                                        arguments: shelter),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image(
                                          image: CachedNetworkImageProvider(
                                            shelter.fotoPerfil,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                TextApp(
                                    text: "¿Rescatas animales?",
                                    fontSize: 20.0,
                                    weight: FontWeight.bold,
                                    color: Colors.black),
                                TextApp(
                                    text:
                                        "Únete y obtén caracteristicas especiales",
                                    fontSize: 18.0,
                                    weight: FontWeight.bold,
                                    color: Colors.grey),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ShelterPromo(),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              )));
  }
}
