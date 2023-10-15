import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../routes/routes.dart';
import '../../theme/colors.dart';
import 'controllers/seguimiento_controller.dart';

class SeguimientoView extends StatelessWidget {
  SeguimientoView({super.key});

  final seguimientoController = Get.find<SeguimientoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor(AppColors.primaryOrange),
          title: const Text('Seguimientos programados'),
        ),
        body: Obx(()=>
           ListView.builder(
            itemCount: seguimientoController.seguimientos.length,
            itemBuilder: (context, index) {
              final seguimiento = seguimientoController.seguimientos[index];
              return ListTile(
                title: Text(DateFormat('yyyy-MM-dd').format(seguimiento.fechaNotificacion)),
                subtitle: const Text("Seguimiento"),
                onTap: () {
                  Get.toNamed(Routes.finalPhoto);
              
                },
              );
            },
          ),
        ),
      );
  
  }

 
}