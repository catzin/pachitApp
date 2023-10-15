import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/global_controllers/global_controller.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:pachitaapp/app/presentation/shared/error_message.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';

import '../../theme/colors.dart';


class FavoriteView extends StatelessWidget {

  final globalController = Get.find<GlobalController>();
  final homeController = Get.find<HomeController>();
  FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       Obx(()=> globalController.favoritePets.isNotEmpty ? 
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextApp(text: 'Mis mascotas favoritas ♥️', fontSize: 18, weight: FontWeight.w500, color: Colors.black, align: TextAlign.start,),
            ),
            Expanded(
              child: FadeInDown(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: globalController.favoritePets.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Número de elementos por línea
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final pets = globalController.favoritePets;
                    return Stack(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Cambia esto a tu valor deseado
                            ),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            imageUrl: pets[index].mascotaImgs[0].path,
                            fit:BoxFit.cover
                          ),
                         ),
                        ),
                        Positioned(
                        bottom: 9,
                        left: 4,
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color:  Colors.red,
                            borderRadius: BorderRadius.circular(2)
                          ),
                          padding: const EdgeInsets.all(8),
                          child: TextApp(text: pets[index].nombre, fontSize: 15, weight: FontWeight.w500, color: Colors.white, align: TextAlign.center,),
                        ),
                        
                      ),
                       Positioned(
                        right: 0,
                        bottom: 0,
                        child: Transform.translate(
                          offset: const Offset(2, 5), // Mueve el botón hacia abajo y hacia la derecha.
                          child: FloatingActionButton(
                            mini: true,
                            onPressed: ()async{
                              final result = await homeController.dislikePetView(pets[index].id);


                              if (result) {
                                      Get.snackbar(
                                        '¡Eliminada!', // Título
                                        'Mascota eliminada de favoritos', // Mensaje
                                        icon: const Icon(
                                            Icons.notification_important,
                                            color: Colors.red), // Icono
                                        snackPosition:
                                            SnackPosition.BOTTOM, // Posición
                                        backgroundColor: HexColor(AppColors
                                            .primaryOrange), // Color de fondo
                                        colorText:
                                            Colors.black, // Color del texto
                                      );
                                    }
                              

                             
                            },
                            backgroundColor: Colors.red,
                            elevation: 8,
                            child: const Icon(Icons.favorite),
                          ),
                        ),
                      )
            
                      ],
                    );
                  },
                 ),
              ),
            ),
          ],
            )
          :  const ErrorMessage(
              principal: 'No tienes mascotas favoritas',
              message: '¡Empieza a likear mascotas disponibles!',
              principalSize: 20,
              messageSize: 18,
              imageWidth: 200,
              imageHeight: 200,
            ),
       );
    
  }
}

