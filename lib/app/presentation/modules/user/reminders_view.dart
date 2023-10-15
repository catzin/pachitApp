import 'package:animate_do/animate_do.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/shelter_controller.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/colors.dart';

class Reminders extends StatelessWidget {
  Reminders({super.key});

  final shelterController = Get.find<ShelterController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: FadeInDownBig(
          child: Obx(() => 
            GridView.builder(
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
                 
            ),
            itemCount: shelterController.reminders.length,
            itemBuilder: (BuildContext context, int index) {

              final item = shelterController.reminders[index];
              
              return FlipCard(
                front: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: HexColor("FFFF99"),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextApp(text:'Recordar el :${DateFormat('dd/MM/yyyy').format(item.fechaEvento!)}', fontSize: 13, weight: FontWeight.w400, color: Colors.red)
                        ],
                      ),
                      TextApp(text: item.descripcion, fontSize: 15, weight: FontWeight.w500, color: Colors.black)
                    ],
                  ),
                ),
                back: Container(
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
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: ()async{
                            if(item.linkCalendar.isEmpty){
                              final uri = Uri(path :item.linkCalendar);
                              if(await canLaunchUrl(uri)){
                                await launchUrl(uri);
                              }
                              else{
                                Get.snackbar('!Upppps!', 'No se pudo abrir');
                              }
                              
                            }
                        
                          },
                          child: const TextApp(
                            text: 'Ver en GoogleCalendar',
                            fontSize: 12,
                            weight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor(AppColors.cancel)
                          ),
                          onPressed: () {},
                          child: const TextApp(
                            text: 'Eliminar',
                            fontSize: 12,
                            weight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
                direction: FlipDirection.HORIZONTAL,
        
              );
            },
                ),
          ),
        ),
    );
  }
}