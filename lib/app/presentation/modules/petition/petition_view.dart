
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../../routes/routes.dart';
import '../../shared/text_app.dart';
import 'widgets/petition_form.dart';

class PetitionView extends StatelessWidget {
  const PetitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Tooltip(
        message: 'Cancelar',
        child: FloatingActionButton(
          onPressed: () => Get.offNamed(Routes.home),
          backgroundColor: Colors.red,
          child: const Icon(LineIcons.removeUser),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TextApp(
                          text: 'Solicitud',
                          fontSize: 30,
                          weight: FontWeight.w500,
                          color: Colors.black),
                      TextApp(
                          text: 'Captura los datos necesarios',
                          fontSize: 18,
                          weight: FontWeight.bold,
                          color: Colors.grey
                          ),
                    ],
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amberAccent),
                    child: const Center(
                      child: Icon(
                        LineIcons.envelope,
                        size: 35,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50,),
              PetittionForm(),
              const SizedBox(height: 10,),
              const TextApp(text: "Utilizaremos esta información para conocer más acerca de tu labor.", fontSize: 16.0, weight: FontWeight.bold, color: Colors.black)
              ],
                
            ),
          ),
        ),
      ),
    );
  }
}