import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/pet/controllers/pet_profileController.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';

import '../../routes/routes.dart';

class PreView extends StatelessWidget {
  PreView({super.key});
  final petProfileController = Get.find<PetProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
             
                  children: [
                      Image.asset(
                       'lib/app/presentation/assets/preAdopt.png',
                     ),
                     const SizedBox(height: 10,),
                     const TextApp(text: 'La adopción es un acto de amor\n¿Estás listo para darlo?', fontSize: 18, weight: FontWeight.w500, color: Colors.black, align: TextAlign.center,)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                        TextFormField(
                          textInputAction: TextInputAction.done,
                        controller: petProfileController.motivosEditing,
                        maxLines: 4,
                        maxLength: 150,
                        decoration:  InputDecoration(
                            hintText: '¿Por qué quieres adoptar a ${petProfileController.petName}?',
                            border: const OutlineInputBorder()),
                        onSaved: (value) => petProfileController.motivosEditing.text = value!,
                      ),
                      Obx(
                        () => petProfileController.isSendingAdoptResquest.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: HexColor(AppColors.primaryOrange),
                                ),
                              )
                            :
                        ExpandedButton(
                          text: const Text("Enviar solicitud"),
                          color: AppColors.primaryOrange,
                          textMode: false,
                          action: () async{
                            final value = await petProfileController.sendPetition();
                            if(value){
                              Get.dialog(
                                
                                AlertDialog(
                                  
                                  title: const Text('¡Solicitud enviada!',textAlign: TextAlign.center,),
                                  content: FractionallySizedBox(
                                    
                                    widthFactor: 0.8,
                                    heightFactor: 0.4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:  const [
                                          TextApp(
                                          text:
                                              "Tu solicitud será evaluada por la organización correspondiente.\nespera respuesta pronto.",
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
                                        Get.offAllNamed(Routes.home); // Cierra el modal
                                      },
                                      child: const Text('¡Listo, entiendo!'),
                                    ),
                                  ],
                                ),
                      
                                barrierDismissible: false
                      
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ExpandedButton(
                        text: const Text("Cancelar"),
                        color: AppColors.cancel,
                        textMode: false,
                        action: () {
                          Get.offAllNamed(Routes.home);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}