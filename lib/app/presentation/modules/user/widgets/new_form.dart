import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';

import '../../../../domain/models/index.dart';
import '../controllers/new_controller.dart';

class NewForm extends StatelessWidget {
  const NewForm({
    super.key,
    required this.newViewController,
  });

  final NewViewController newViewController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: newViewController.registerKey,
      child: Column(
        children: [
          Row(
            children: [
               Expanded(
                flex: 2,
                child: TextFormField(
                  controller: newViewController.petNombre,
                  onSaved: (value) => newViewController.petNombre.text = value!,
                  
                  decoration: const InputDecoration(
                    prefixIcon: Icon(LineIcons.dog),
                    labelText: 'Nombre',
                    hintText: 'Ingresa nombre',
                    border: OutlineInputBorder(),
                  ),
                  
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Obx(
                  () => DropdownButtonFormField(
                    
                    decoration: const InputDecoration(
                      hintText:'Sexo',
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    items: newViewController.petSex
                        .map<DropdownMenuItem<String>>((String pet) {
                      return DropdownMenuItem<String>(
                        value: pet,
                        child: Text(pet),
                      );
                    }).toList(),
                    onChanged: (value) => newViewController.petSexo.text = value!,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
       
                child: Obx(
                  () => DropdownButtonFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(LineIcons.bone),
                      hintText:'Tipo de mascota',
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    items: newViewController.petOptions
                        .map<DropdownMenuItem<String>>((PetType pet) {
                      return DropdownMenuItem<String>(
                        value: pet.idtipoMascota.toString(),
                        child: Text(pet.mascota),
                      );
                    }).toList(),
                 
                    onChanged: (value) => newViewController.petTipo.text = value!,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),

          Row(
            children: [
              Expanded(
        
                child: Obx(
                  () => DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:'Edad'
                    ),
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    items: newViewController.petAge
                        .map<DropdownMenuItem<String>>((PetAgeResponse petEdad) {
                      return DropdownMenuItem<String>(
                        value: petEdad.idEdad.toString(),
                        child: Text(petEdad.descripcion),
                      );
                    }).toList(),
                    onChanged: (value) => newViewController.petEdad.text = value!,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),
         
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Obx(
                  () => DropdownButtonFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(LineIcons.bone),
                      hintText:'Raza',
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    items: newViewController.raza
                        .map<DropdownMenuItem<String>>((RazaType raza) {
                      return DropdownMenuItem<String>(
                        value: raza.idtipoRaza.toString(),
                        child: Text(raza.mascota),
                      );
                    }).toList(),
                    onChanged: (value) => newViewController.petRaza.text = value!,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(
                  () => DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:'Actividad'
                    ),
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    items: newViewController.activityLevel
                        .map<DropdownMenuItem<String>>((NivelActividad petEdad) {
                      return DropdownMenuItem<String>(
                        value: petEdad.idnivelActividad.toString(),
                        child: Text(petEdad.nombre),
                      );
                    }).toList(),
                    onChanged: (value) => newViewController.petActividad.text = value!,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: newViewController.petDescripcion,
            maxLines: 10,
            maxLength: 500,
            decoration: const InputDecoration(
              hintText: 'Ingresa tus comentarios aquí',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => newViewController.petDescripcion.text = value!,
          ),

          const SizedBox(height: 10,),
          const TextApp(text: "¿Requieres que se deshabilite la adopción en noviembre?", fontSize: 15, weight: FontWeight.w500, color: Colors.black, align: TextAlign.center,),
          const SizedBox(height: 10,),
          DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:'Deshabilitar'
                    ),
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    items: newViewController.disableOptions
                        .map<DropdownMenuItem<String>>((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value){
                      if(value!.contains("No")){
                        newViewController.disableSelected.value = 0;
                      }
                      else{
                        newViewController.disableSelected.value = 1;
                      }
                    },
                  ),
        ],
      ),
    );
  }
}



