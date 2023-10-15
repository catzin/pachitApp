import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class PetList extends StatelessWidget {
  PetList({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.petList.length,
        itemBuilder: (context, index) {
          return  ListTile(
            title:Text(homeController.petList[index].nombre),
          );
        },
    
      ),
    );
  }
}