import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/global_controllers/global_controller.dart';

import '../../../domain/models/adoption_user.dart';
// ignore: unused_import
import '../../routes/routes.dart';
import 'controllers/request_user_controller.dart';

class RequestUserView extends StatelessWidget {
   RequestUserView({super.key});

   final global = Get.find<GlobalController>();

  final List<AdoptionRequestUser> requests = [
    AdoptionRequestUser(petImage:'https://pachstorage.s3.amazonaws.com/16861141997721686114179914.jpg',petName: 'Sparki',status: true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Solicitudes Recientes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 30,),
        Expanded(
          child: Obx(()=>
            ListView.builder(
              itemCount: global.requestUser.length,
              itemBuilder: (context, index) {
                final request = global.requestUser[index];
                return ListTile(
                  onTap: (){
                    Get.toNamed(Routes.candidateMotives, arguments: request);
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(request.mascota.mascotaImgs[0].path),
                    radius: 25,
                  ),
                  title: Text(request.mascota.nombre),
                  trailing: const Icon(LineIcons.arrowCircleRight)
                );
              },
            ),
          ),
        ),
       
          
        ],
      )
    );
  }
}