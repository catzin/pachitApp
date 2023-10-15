import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/new_controller.dart';
import '../../../theme/colors.dart';

class UploadLayout extends StatelessWidget {
  const UploadLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Row(children: [
        Expanded(
          flex: 2,
          child: CustomPicker(index:  0),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomPicker(index:  1),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(flex: 1, child: CustomPicker(index:  2)),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class CustomPicker extends StatelessWidget {
  CustomPicker({
    super.key,
    required this.index
  });

  final int index;

  final newController = Get.find<NewViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
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
              await newController.getImageOne(index, 0);
            break;
            case 1: 
              await newController.getImageOne(index, 1);
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
              await newController.popImage(index);
            break;
         

          }
          

        },
        child: Container(
          decoration: BoxDecoration(
              color: HexColor(AppColors.blueAccent).withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              image: newController.listPathImages[index] == ''
                  ? null
                  : DecorationImage(
                      image: FileImage(File(newController.listPathImages[index])),
                      fit: BoxFit.cover),
          ),
         child: newController.listPathImages[index] == '' ? const Center(child:Icon(LineIcons.plus)) : null,
        ),

      ),
    );
  }
}
