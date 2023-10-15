import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pachitaapp/app/presentation/modules/pet/controllers/pet_profileController.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/routes/routes.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';
import 'package:like_button/like_button.dart';
import '../../shared/text_app.dart';

class PetProfile extends StatelessWidget {
  PetProfile({super.key});

  final profileController = Get.find<PetProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => profileController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 6,
              color: HexColor(AppColors.primaryOrange),
            ))
          : Stack(
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          profileController.images[0].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme: const IconThemeData(color: Colors.amberAccent, size: 20),
                    leading: InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                            color: Colors.amberAccent, shape: BoxShape.circle),
                        child: const Icon(
                          LineIcons.arrowLeft,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                const BottomModal()
              ],
            )),
    );
  }
}

class BottomModal extends StatelessWidget {
  const BottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: BottomContent(scrollController: scrollController),
          );
        });
  }
}

class BottomContent extends StatelessWidget {
  final profileController = Get.find<PetProfileController>();
  BottomContent({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextApp(
                  text: profileController.info.nombre,
                  fontSize: 35,
                  weight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextApp(
                      text: 'Nivel de actividad',
                      fontSize: 20,
                      weight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    TextApp(
                      text: profileController
                          .info.nivelActividadIdnivelActividad.nombre,
                      fontSize: 16,
                      weight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    Obx(
                      () => LikeButton(
                        isLiked: profileController.isLiked.value,
                        likeCount: profileController.likes.value,
                        onTap: (bool isLiked) async {
                          if (isLiked) {
                            profileController.dislike();
                          } else {
                            profileController.likePet();
                          }
                          return !isLiked;
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextApp(
                    text: 'Acerca de ${profileController.info.nombre}',
                    fontSize: 16,
                    weight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    profileController.info.descripcion,
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextApp(
                    text: 'Edad : ${profileController.info.edad.descripcion}',
                    fontSize: 16,
                    weight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Caracteristicas 😀',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  profileController.info.caracteristicas.isNotEmpty
                      ? SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  profileController.info.caracteristicas.length,
                              itemBuilder: (context, index) {
                                final nombre = profileController.info
                                    .caracteristicas[index].nombre.capitalize;
                                return Container(
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 5.0),
                                  decoration: BoxDecoration(
                                    color: HexColor(AppColors.primaryOrange),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      nombre!,
                                      style: GoogleFonts.ibmPlexSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : const Text("Sin caracteristicas")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.toNamed(Routes.petGallery);
                            },
                            child: const TextApp(
                              text: 'Más fotos 📸 >',
                              fontSize: 16,
                              weight: FontWeight.bold,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: ListView.builder(
                        itemCount: profileController.images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Get.toNamed(Routes.petGallery);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    profileController.images[index].path,
                                  ),
                                )),
                              ),
                            )),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                TextApp(
                                  text: 'Donar',
                                  fontSize: 18,
                                  weight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(LineIcons.moneyBill)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  HexColor(AppColors.primaryOrange)),
                          onPressed: () async{
             
                            if(!profileController.isShlelter){
                              Get.offAllNamed(Routes.razonesAdopt,arguments: profileController.info.nombre);
                            }
                            else{
                              Get.toNamed(Routes.errorAdopt);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                TextApp(
                                  text: 'Adóptame',
                                  fontSize: 18,
                                  weight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(LineIcons.dog)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


