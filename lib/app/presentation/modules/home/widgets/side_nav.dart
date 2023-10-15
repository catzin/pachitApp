
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import '../../../routes/routes.dart';
import '../../../shared/brand_bar.dart';
import '../../../theme/colors.dart';
import '../controllers/home_controller.dart';

class SideNav extends StatelessWidget {
  const SideNav({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: HexColor(AppColors.primaryOrange)),
            child: const BrandBar()
          ),
          ListTile(
            leading: const Icon(LineIcons.personEnteringBooth),
            title: const Text('Perfil'),
            onTap: () {
          
              Get.back();
              Get.toNamed(Routes.userProfile);
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Salir'),
            onTap: () async{
              homeController.logOut();
             
              Get.offAllNamed(Routes.start);
            
            },
          ),

          ListTile(
            title: const Text('Aviso de privacidad'),
             leading: const Icon(LineIcons.key),
            onTap: () async{
              Get.back();
              Get.toNamed(Routes.privacy);
              
            },
          ),

          ListTile(
            title: const Text('Ubicación'),
             leading: const Icon(LineIcons.key),
            onTap: () async{
              print('clickeado');
              await homeController.getLocation();
              
            },
          )
        ],
      ),
    );
  }
}
