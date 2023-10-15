import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import 'package:pachitaapp/app/presentation/shared/tittle_section.dart';
import '../../shared/index.dart';
import '../../theme/colors.dart';
import 'controllers/contact_controller.dart';

class ContactView extends StatelessWidget {
  ContactView({super.key});
  final contactController = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Horario de contacto"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const TitleSection(
                  title: 'Horario',
                  subTitle: 'Ingresa tu horario de contacto',
                icon: LineIcons.clock,
              ),
              const SizedBox(
                height: 20,
              ),
              const TextApp(
                text:
                    'Esto tiene como finalidad establecer una mejor relación entre organización - usuario a la hora de establecer una entrevista con los responsables de la mascota',
                fontSize: 15,
                weight: FontWeight.bold,
                color: Colors.grey,
                align: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
           
                TextField(
                  maxLength: 255,
                  controller: contactController.contact,
                  maxLines:5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '¿Cuando estás disponible?',
                  ),
                  
                             ),
               
               const SizedBox(
                height: 20,
              ),
      
              Obx(() => contactController.uploadContact.value ? const Center(child: CircularProgressIndicator(color: Colors.orangeAccent),) : 
                ExpandedButton(
                  text:  const Text("Actualizar"),
                  color: AppColors.primaryOrange,
                  textMode: false,
                  action: ()async{
                    if(contactController.existHour.value){
                     
                      final result = await contactController.updateContactHour();

                      if (result == true) {
                            // Get.back();
                            // Get.snackbar(
                            //     '¡Registro exitoso!', 'Horario registrado',
                            //     backgroundColor:
                            //       HexColor(AppColors.primaryOrange),
                            // );


                            Get.dialog(
                                
                                AlertDialog(
                                  
                                  title: const Text('¡Actualizado!',textAlign: TextAlign.center,),
                                  content: FractionallySizedBox(
                                    
                                    widthFactor: 0.8,
                                    heightFactor: 0.4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:  const [
                                          TextApp(
                                          text:
                                              "Tu horario de contacto ha sido actualizado correctamente",
                                          fontSize: 16,
                                          weight: FontWeight.bold,
                                          color: Colors.black,
                                          align: TextAlign.center,
                                        ),
                                        Icon(
                                          LineIcons.handshakeAlt,
                                          size: 60,
                                          color: Colors.blue
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:  HexColor(AppColors.primaryOrange),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                        Get.back();
                                          // Cierra el modal
                                      },
                                      child: const Text('¡Listo!'),
                                    ),
                                  ],
                                ),
                      
                                barrierDismissible: false
                      
                              );
                          }
                      

                    }
                    else{
                  
                      final result = await contactController.saveContactHour();
                          if (result == true) {
                             Get.dialog(
                                
                                AlertDialog(
                                  
                                  title: const Text('¡registrado!',textAlign: TextAlign.center,),
                                  content: FractionallySizedBox(
                                    
                                    widthFactor: 0.8,
                                    heightFactor: 0.4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:  const [
                                          TextApp(
                                          text:
                                              "Tu horario de contacto ha sido registado correctamente",
                                          fontSize: 16,
                                          weight: FontWeight.bold,
                                          color: Colors.black,
                                          align: TextAlign.center,
                                        ),
                                        Icon(
                                          LineIcons.handshakeAlt,
                                          size: 60,
                                          color: Colors.blue
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:  HexColor(AppColors.primaryOrange),
                                      ),
                                      onPressed: () {
                                        Get.back();  // Cierra el modal
                                        Get.back();
                                      },
                                      child: const Text('¡Listo, entiendo!'),
                                    ),
                                  ],
                                ),
                      
                                barrierDismissible: false
                      
                              );
                          }

                    }
               
                    
                  },
                ),
              )
            ],
              
          ),
        ),
    
    );
  }
}
