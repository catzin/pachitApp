import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/domain/models/parentesco_item.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/reference_controller.dart';

import '../../../shared/expanded_button.dart';
import '../../../shared/text_app.dart';
import '../../../theme/colors.dart';

class ReferenceForm extends StatelessWidget {
  const ReferenceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final referenceController = Get.find<ReferenceController>();

    return Form(
      key: referenceController.referenceKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: referenceController.nombre,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.user),
              labelText: 'Nombre',
              hintText: 'Ingresa nombre',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              referenceController.nombre.text = value!;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: referenceController.apPaterno,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.user),
              labelText: 'Apellido Paterno',
              hintText: 'Ingresa apellido',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              referenceController.apPaterno.text = value!;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: referenceController.apMaterno,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.user),
              labelText: 'Apellido Materno',
              hintText: 'Ingresa apellido',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              referenceController.apMaterno.text = value!;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: referenceController.telefono,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.user),
              labelText: 'Teléfono',
              hintText: 'Ingresa teléfono',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              referenceController.telefono.text = value!;
            },
          ),
          const SizedBox(height: 20),
          Obx(() => DropdownButtonFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                items: referenceController.parentescos
                    .map<DropdownMenuItem<ParentescoItem>>(
                        (ParentescoItem value) {
                  return DropdownMenuItem<ParentescoItem>(
                    value: value,
                    child: Text(value.parentesco),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    referenceController.parentId.value = value.idparentesco;
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(LineIcons.user),
                  labelText: 'Parentesco',
                  hintText: '¿Qué es de ti?',
                  border: OutlineInputBorder(),
                ),
              )),
          const SizedBox(height: 20),
          Obx(() => referenceController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ExpandedButton(
                  text: const Text("Crear"),
                  color: AppColors.primaryOrange,
                  textMode: false,
                  action: () async {
                    final result = await referenceController.createReference();

                    if (result) {
                      Get.dialog(
                          AlertDialog(
                            title: const Text(
                              'Creado!',
                              textAlign: TextAlign.center,
                            ),
                            content: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  TextApp(
                                    text:
                                        "Tu contacto de referencia ha sido registrada correctamente",
                                    fontSize: 16,
                                    weight: FontWeight.bold,
                                    color: Colors.black,
                                    align: TextAlign.center,
                                  ),
                                  Icon(LineIcons.handshakeAlt,
                                      size: 60, color: Colors.blue)
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      HexColor(AppColors.primaryOrange),
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
                          barrierDismissible: false);
                    }
                    else{
                      Get.snackbar('!Upsss!', 'Algo salió mal');

                    }
                  },
                ))
        ],
      ),
    );
  }
}
