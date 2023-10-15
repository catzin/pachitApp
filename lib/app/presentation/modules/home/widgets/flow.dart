import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/flow_controller.dart';
import '../../../routes/routes.dart';
import '../../../theme/colors.dart';


class CustomDial extends StatelessWidget {
  CustomDial({
    super.key,
  });

  final flowController = Get.find<FlowControlller>();

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
    
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22.0),
        visible: true,
         
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: const Icon(LineIcons.dog),
            backgroundColor: HexColor(AppColors.primaryOrange),
            onTap: () =>  Get.toNamed(Routes.newPet),
            label: 'Nueva mascota',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: HexColor(AppColors.secondaryLight)
          ),
          SpeedDialChild(
            child:const Icon(LineIcons.home),
                   backgroundColor: HexColor(AppColors.primaryOrange),
            onTap: ()async{
              final shelterInfo = await flowController.getMySheltInfo();
              Get.toNamed(Routes.shelter, arguments: shelterInfo);
            },
            label: 'Mi organización',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: HexColor(AppColors.secondaryLight)
          ),
          SpeedDialChild(
            child:const Icon(LineIcons.calendarAlt),
                   backgroundColor: HexColor(AppColors.primaryOrange),
            onTap: ()async{

              final shelterInfo = await flowController.getMySheltInfo();
              Get.toNamed(Routes.creaRecordatorio, arguments: shelterInfo);
   

            },
            label: 'Crear recordatorio',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: HexColor(AppColors.secondaryLight)
          ),

          SpeedDialChild(
            child:const Icon(LineIcons.infoCircle),
                   backgroundColor: HexColor(AppColors.primaryOrange),
            onTap: ()async{

              final shelterInfo = await flowController.getMySheltInfo();
              Get.toNamed(Routes.searchIncidence, arguments: shelterInfo);
   

            },
            label: 'Incidente',
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: HexColor(AppColors.secondaryLight)
          ),
        ],
      );
  }
}
