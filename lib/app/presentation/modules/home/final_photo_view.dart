import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';

import 'controllers/final_photo_controller.dart';

class FinalPhotoView extends StatelessWidget {
  FinalPhotoView({super.key});
  final photoController = Get.find<FinalPhotoController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Foto de seguimiento"),backgroundColor: HexColor(AppColors.primaryOrange),),
      body:  Center(
        child: InkWell(
          onTap: ()async{
            final result = await photoController.getImages();
          },
          child:const Icon(
            LineIcons.file,
            size: 80,
          ),
        ),
        
        
      ),
    );
  }
}