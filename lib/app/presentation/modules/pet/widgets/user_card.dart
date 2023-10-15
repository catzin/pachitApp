import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/domain/models/request_by_pet.dart';

import '../../../routes/routes.dart';
import '../../../theme/colors.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.avatarUrl, required this.name, required this.occupation, required this.age, required this.user, required this.idmascota});

  final String avatarUrl;
  final String name;
  final String occupation;
  final String age;
  final RequestPet user;
  final int idmascota;
  

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: FrontCard(avatarUrl: avatarUrl, name: name,occupation: occupation,age: age,),
      back: BackCard(user:  user, idmascota: idmascota,),
    );
  }  
}


class BackCard extends StatelessWidget {
  const BackCard({super.key, required this.user, required this.idmascota});
  final RequestPet user;
  final int idmascota;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: HexColor(AppColors.blueLight),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2.0,
            blurRadius: 5.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child : ElevatedButton(onPressed: (){

          Get.toNamed(Routes.candidateView , arguments: { 'user':user,'idmascota':idmascota });
        }, child: const Text("Ver mas"))
      ),
    );
  }
}

class FrontCard extends StatelessWidget {
  const FrontCard({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.occupation,
    required this.age,
  }) : super(key: key);

  final String avatarUrl;
  final String name;
  final String occupation;
  final String age;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2.0,
            blurRadius: 5.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(height: 10.0),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5.0),
              Text(
                occupation,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5.0),
              Text(
                age,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
