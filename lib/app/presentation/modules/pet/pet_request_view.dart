import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../theme/colors.dart';
import 'controllers/pet_request_controller.dart';
import 'widgets/user_card.dart';

class PetRequestView extends StatelessWidget {
  PetRequestView({Key? key}) : super(key: key);
  final petRequestController = Get.find<PetRequestController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Interesados"),
      ),
      body: Obx(()=>
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              shrinkWrap: true, // Agrega esta línea
              physics: const NeverScrollableScrollPhysics(), // Agrega esta línea
              itemCount: petRequestController.persons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                final person = petRequestController.persons[index].usuario;
                final difference =  DateTime.now().difference(person.fechaNacimiento);
                final age = (difference.inDays / 365).floor();
                return UserCard(
                  user: petRequestController.persons[index],
                  avatarUrl: person.fotoPerfil.contains("https") ? person.fotoPerfil : 'https://pachstorage.s3.amazonaws.com/avatar_profile.png' ,
                  name: person.nombre,
                  occupation: person.ocupacionIdOcupacion.ocupacion,
                  age:'Edad :${age.toString()}',
                  idmascota: petRequestController.idMascota,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
