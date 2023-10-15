import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:pachitaapp/app/presentation/shared/index.dart';

import '../../routes/routes.dart';
import '../../shared/text_app.dart';
import '../../theme/colors.dart';
import 'controllers/motives_controller.dart';

class UserMotivesView extends StatelessWidget {
  UserMotivesView({super.key});
  final motivesController = Get.find<MotivesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
      ),
      body: FadeInRight(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextApp(text: 'Detalles', fontSize: 25, weight: FontWeight.bold, color: Colors.blue),
                const SizedBox(height: 5,),
                TextApp(text: 'Fecha de solicitud: ${DateFormat('dd/MM/yyyy').format(motivesController.args.fechaSolicitud)}', fontSize: 16, weight: FontWeight.bold, color: Colors.black),
                const SizedBox(height: 5,),
                const TextApp(text: 'Motivos enviados', fontSize: 25, weight: FontWeight.bold, color: Colors.blue),
                TextApp(text: motivesController.args.motivo, fontSize: 16, weight: FontWeight.w500, color: Colors.black),
                const SizedBox(height: 10,),
                const TextApp(text: 'Estatus de la solicitud', fontSize: 25, weight: FontWeight.bold, color: Colors.blue),
                Row(
                  children: [
                    TextApp(text: motivesController.args.estatus == 1 ? 'En revisión' : motivesController.args.estatus == 2 ? 'Cancelada' : 'Aceptada' , fontSize: 16, weight: FontWeight.w500, color: Colors.black),
                    const SizedBox(width: 10,),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:  motivesController.args.estatus == 1 ? Colors.deepOrange : motivesController.args.estatus == 2 ? Colors.red  : Colors.green,
                      ),
                      
                    )
                  ],
      
                  
                ),
                const SizedBox(height: 20,),
                const TextApp(text: 'Mascota', fontSize: 25, weight: FontWeight.w500, color: Colors.black),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    TextApp(text: motivesController.args.mascota.nombre, fontSize: 20, weight: FontWeight.w500, color: Colors.black)
                  ],
                ),

                const SizedBox(height: 20,),

                 Align(
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: CachedNetworkImageProvider(motivesController.args.mascota.mascotaImgs[0].path),
                  ),
                ),

                const SizedBox(height: 30,),
                motivesController.args.estatus == 3 ?
                ExpandedButton(
                  text: const Text("Ver seguimientos"),
                  color: AppColors.primaryOrange,
                  textMode: false,
                  action: () {

                    Get.toNamed(Routes.seguimientoView);
                    
                  },
                ): Container()
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}