import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/upgrade_controller.dart';
import '../../shared/text_app.dart';
import '../../theme/colors.dart';
import 'widgets/form_org.dart';

class CreateOrg extends StatelessWidget {
  const CreateOrg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children:[
                const TitleSection(),
                const SizedBox(height: 30,),
                const TextApp(text: 'Sube una foto de perfil y una de portada', fontSize: 16, weight: FontWeight.w500, color: Colors.black),
                SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CustomPicker(index: 0),
                      ),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CustomPicker(index: 1),
                      ),
                    ],
                  ),
                ),
                FormOrg(),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPicker extends StatelessWidget {
  CustomPicker({
    super.key,
    required this.index
  });

  final int index;

  final upgradeController = Get.find<UpgradeController>();

  @override
  Widget build(BuildContext context) {
    return 
       GestureDetector(
        onTap: ()async{
          final result = await showConfirmationDialog(
            context: context,
            title: 'Tomar imagen de',
            actions: const[
              AlertDialogAction(key: 0, label: 'Galeria'),
              AlertDialogAction(key: 1, label: 'Camara'),
            ]
          );

          switch(result){
            case 0: 
              await upgradeController.getImageOne(index, 0);
            break;
            case 1: 
              await upgradeController.getImageOne(index, 1);
            break;

          }
        },

        onLongPress: ()async{

          final result = await showConfirmationDialog(
            context: context,
            title: 'Editar',
            actions: const[
              AlertDialogAction(key: 0, label: 'Eliminar',textStyle: TextStyle(color: Colors.red)),
            ]
          );

          switch(result){
            case 0: 
              await upgradeController.popImage(index);
            break;
         

          }
          

        },
        child: Obx(() =>
          Container(
            decoration: BoxDecoration(
                color: HexColor(AppColors.blueAccent).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                image: upgradeController.listPathImages[index].isEmpty
                    ? null
                    : DecorationImage(
                        image: FileImage(File(upgradeController.listPathImages[index])),
                        fit: BoxFit.cover),
            ),
           child: upgradeController.listPathImages[index].isEmpty ? const Center(child:Icon(LineIcons.plus)) : null,
          ),
        ),

      
    );
  }
}


class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextApp(
                text: 'Crear perfil',
                fontSize: 30,
                weight: FontWeight.w500,
                color: Colors.black),
            TextApp(
                text: 'Todo listo rellena los campos',
                fontSize: 18,
                weight: FontWeight.bold,
                color: Colors.grey),
          ],
        ),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.amberAccent),
          child: const Center(
            child: Icon(
              LineIcons.home,
              size: 35,
            ),
          ),
        )
      ],
    );
  }
}
