import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/upgrade_controller.dart';
import 'package:pachitaapp/app/presentation/shared/index.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';

class FormOrg extends StatelessWidget {
  FormOrg({super.key});

  final upgradeController = Get.find<UpgradeController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: upgradeController.orgKey,
      child: Column(
        children: [
          TextFormField(
            controller: upgradeController.nombreOrg,
            validator: (value){
              return upgradeController.validateEmpty(value!);
            },
            onSaved: (value) => upgradeController.nombreOrg.text = value!,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.damagedHouse),
              labelText: 'Nombre',
              hintText: 'Ingresa nombre',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
           TextFormField(
            controller: upgradeController.deescripcion,
            validator: (value) => upgradeController.validateEmpty(value!),
            onSaved: (value) => upgradeController.deescripcion.text = value!,
            maxLines: 10,
            maxLength: 500,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              hintText: 'Cuentanos acerca de tu organización',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20, 
          ),
          TextFormField(
            controller: upgradeController.linkDonacion,
            onSaved: (value) =>  upgradeController.linkDonacion.text = value!,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.link),
              labelText: 'Donación',
              hintText: 'Ingresa un link de donación',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),
          Obx(() => upgradeController.isSending.value ? const Center(child: CircularProgressIndicator(),) :

          ExpandedButton(
            text: const Text("Crear"),
            color: AppColors.primaryOrange,
            textMode: false,
            action: ()async{
              upgradeController.validateAccount();
              upgradeController.createOrganization();
            },
          )
          
          
           )
          
        ],
      ),
    );
  }
}
