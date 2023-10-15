import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/user_controller.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import '../../../../domain/models/index.dart';
import '../../../theme/colors.dart';

class EditForm extends StatelessWidget {
  final UserController userController;
  const EditForm({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            TextApp(
              text: 'Contacto',
              fontSize: 20,
              weight: FontWeight.w500,
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: userController.facebook,
          onSaved: (value) => userController.facebook.text = value!,
          decoration: const InputDecoration(
            prefixIcon: Icon(LineIcons.link),
            labelText: 'Facebook',
            //hintText: 'Ingresa un link de facebook',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: userController.instagram,
          onSaved: (value) => userController.instagram.text = value!,
          decoration: const InputDecoration(
            prefixIcon: Icon(LineIcons.link),
            labelText: 'Instagram',
            hintText: 'Ingresa un link de instagram',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            TextApp(
              text: 'Acerca de mi',
              fontSize: 20,
              weight: FontWeight.w500,
              color: Colors.black,
            ),
          ],
        ),
        Obx(() => SizedBox(
              height:
                  50, // Establece la altura deseada para el menú desplegable
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      userController.sexOptions.value
                          .firstWhere(
                            (sex) =>
                                sex.idSexo ==
                                userController.userData.value.sexoIdSexo.idSexo,
                            orElse: () => Sex(
                                idSexo: 0,
                                sexo:
                                    'Selecciona sexo'), // Opción por defecto si no se encuentra la ocupación seleccionada
                          )
                          .sexo,
                    ),
                  ),
                  PopupMenuButton<Sex>(
                    icon: const Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) {
                      return userController.sexOptions.value.map((sex) {
                        return PopupMenuItem<Sex>(
                          value: sex,
                          child: Text(sex.sexo),
                        );
                      }).toList();
                    },
                    onSelected: (Sex? selectedSex) {
                      if (selectedSex != null) {
                        userController.userData.update(
                          (val) {
                            val!.sexoIdSexo.idSexo = selectedSex.idSexo;
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            )),
        Obx(() => SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      userController.civilOptions.value
                          .firstWhere(
                            (civil) =>
                                civil.idEstadoCivil ==
                                userController.userData.value
                                    .estadoCivilIdEstadoCivil.idEstadoCivil,
                            orElse: () => CivilState(
                                idEstadoCivil: 0,
                                estadoCivil: 'Selecciona estado civil'),
                          )
                          .estadoCivil,
                    ),
                  ),
                  PopupMenuButton<CivilState>(
                    icon: const Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) {
                      return userController.civilOptions.value.map((civil) {
                        return PopupMenuItem<CivilState>(
                          value: civil,
                          child: Text(civil.estadoCivil),
                        );
                      }).toList();
                    },
                    onSelected: (CivilState? selectedCivil) {
                      if (selectedCivil != null) {
                        userController.userData.update(
                          (val) {
                            val!.estadoCivilIdEstadoCivil.idEstadoCivil =
                                selectedCivil.idEstadoCivil;
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            )),
        Obx(() => SizedBox(
              height:
                  50, // Establece la altura deseada para el menú desplegable
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      userController.ocupationsOptions.value
                          .firstWhere(
                            (ocupacion) =>
                                ocupacion.idOcupacion ==
                                userController.userData.value
                                    .ocupacionIdOcupacion.idOcupacion,
                            orElse: () => Ocupation(
                                idOcupacion: 0,
                                ocupacion:
                                    'Seleccione una ocupación'), // Opción por defecto si no se encuentra la ocupación seleccionada
                          )
                          .ocupacion,
                    ),
                  ),
                  PopupMenuButton<Ocupation>(
                    icon: const Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) {
                      return userController.ocupationsOptions.value
                          .map((ocupacion) {
                        return PopupMenuItem<Ocupation>(
                          value: ocupacion,
                          child: Text(ocupacion.ocupacion),
                        );
                      }).toList();
                    },
                    onSelected: (Ocupation? selectedOcupation) {
                      if (selectedOcupation != null) {
                        userController.userData.update(
                          (val) {
                            val!.ocupacionIdOcupacion.idOcupacion =
                                selectedOcupation.idOcupacion;
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            )),
        Obx(() => SizedBox(
              height:
                  50, // Establece la altura deseada para el menú desplegable
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      userController.residenceOptions.value
                          .firstWhere(
                            (residence) =>
                                residence.idTipoDomicilio ==
                                userController
                                    .userData
                                    .value
                                    .tipodomicilioIdTipoDomicilio
                                    .idTipoDomicilio,
                            orElse: () => Residence(
                                idTipoDomicilio: 0,
                                domicilio:
                                    'Seleccione un domicilio'), // Opción por defecto si no se encuentra la ocupación seleccionada
                          )
                          .domicilio,
                    ),
                  ),
                  PopupMenuButton<Residence>(
                    icon: const Icon(Icons.arrow_drop_down),
                    itemBuilder: (BuildContext context) {
                      return userController.residenceOptions.value
                          .map((residence) {
                        return PopupMenuItem<Residence>(
                          value: residence,
                          child: Text(residence.domicilio),
                        );
                      }).toList();
                    },
                    onSelected: (Residence? selectedResidence) {
                      if (selectedResidence != null) {
                        userController.userData.update(
                          (val) {
                            val!.tipodomicilioIdTipoDomicilio.idTipoDomicilio =
                                selectedResidence.idTipoDomicilio;
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => userController.isUpdating.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ExpandedButton(
                  text: const Text("Actualizar"),
                  color: AppColors.primaryOrange,
                  textMode: false,
                  action: () async {
                    final result = await userController.updateInformation();

                    if(result){
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
                                              "Tu información ha sido actualizada correctamente",
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

                    else{

                      Get.snackbar('!Upppps!', 'Algo salió mal');
                    }
                  },
                ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
