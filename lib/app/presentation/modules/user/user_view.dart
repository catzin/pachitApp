import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/global_controllers/global_controller.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/user_controller.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';



import '../../routes/routes.dart';
import '../../shared/image_viewer.dart';
import '../../theme/colors.dart';

class UserView extends StatelessWidget {
  UserView({super.key});
  final globalController = Get.find<GlobalController>();
  final homeController = Get.find<HomeController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Perfil"),
      ),
      body: Obx(
        () => userController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: Colors.orangeAccent),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ImageViewer(path:homeController.avatar.value);
                                    },
                                  );
                                },
                                onDoubleTap: () async {
                                  final result = await showConfirmationDialog(
                                      context: context,
                                      title: 'Tomar imagen de',
                                      actions: const [
                                        AlertDialogAction(
                                            key: 0, label: 'Galeria'),
                                        AlertDialogAction(
                                            key: 1, label: 'Camara'),
                                      ]);

                                  switch (result) {
                                    case 0:
                                      await userController.getImageOne(0);
                                      break;
                                    case 1:
                                      await userController.getImageOne(1);
                                      break;
                                  }
                                },
                                child: Obx(
                                  () => userController.changingImage.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.blue,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            homeController.avatar.value,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextApp(
                                  text: homeController.activeUSer.value,
                                  fontSize: 15,
                                  weight: FontWeight.normal,
                                  color: Colors.black)
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ListTile(
                            onTap: () => Get.toNamed(Routes.editProfile),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Editar informacion"),
                                Icon(
                                  Icons.arrow_circle_right,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () => Get.toNamed(Routes.signature),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Agregar firma"),
                                Icon(
                                  Icons.arrow_circle_right,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          Obx(
                            () => globalController.isShelter.value
                                ? Container()
                                : ListTile(
                                    onTap: () =>
                                        Get.toNamed(Routes.adoptProfile),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("Perfil de adoptante"),
                                        Icon(
                                          Icons.arrow_circle_right,
                                          color: Colors.blue,
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                          Obx(
                            () => globalController.isShelter.value
                                ? Container()
                                : ListTile(
                                    onTap: () =>
                                        Get.toNamed(Routes.referencias),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("Añadir referencias"),
                                        Icon(
                                          Icons.arrow_circle_right,
                                          color: Colors.blue,
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                          Obx(
                            () => globalController.isShelter.value
                                ? Container()
                                : ListTile(
                                    onTap: () =>
                                        Get.toNamed(Routes.residenceEvidence),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("Añadir evidencia de domicilio"),
                                        Icon(
                                          Icons.arrow_circle_right,
                                          color: Colors.blue,
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                          Obx(
                            () => globalController.isShelter.value
                                ? Container()
                                : ListTile(
                                    onTap: () =>
                                        Get.toNamed(Routes.contactHours),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("Editar horario de contacto"),
                                        Icon(
                                          Icons.arrow_circle_right,
                                          color: Colors.blue,
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                          // Obx(
                          //   () => globalController.isShelter.value
                          //       ? Container()
                          //       : ListTile(
                          //           onTap: () =>
                          //               Get.toNamed(Routes.previusPets),
                          //           title: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: const [
                          //               Text("Añadir mascota previa"),
                          //               Icon(
                          //                 Icons.arrow_circle_right,
                          //                 color: Colors.blue,
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          // ),
                          Obx(
                            () => globalController.isShelter.value
                                ? Container()
                                : ListTile(
                                    onTap: () =>
                                        Get.toNamed(Routes.documentsEvidence),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("Añadir documentos de identidad"),
                                        Icon(
                                          Icons.arrow_circle_right,
                                          color: Colors.blue,
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

