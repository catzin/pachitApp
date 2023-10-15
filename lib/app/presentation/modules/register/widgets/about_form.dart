import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/enums/index.dart';
import 'package:pachitaapp/app/domain/models/index.dart';
import 'package:pachitaapp/app/presentation/routes/routes.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';
import '../../../shared/text_input.dart';
import '../controller/register_controller.dart';
import 'package:intl/intl.dart';


class AboutForm extends StatelessWidget {
  AboutForm({super.key});
  final regController = Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: regController.registerFormKey,
        child: 
          Column(
            children: [
              TextFormField(
                
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: setInputStyles('Nombre', const Icon(Icons.abc)),
                keyboardType: TextInputType.name,
                controller: regController.nombre,
                onSaved: (value) {
                  regController.name.value = value!;
                },
                validator: (value){
                  return regController.validateField(value!, TypeInput.name);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                    setInputStyles('Apellido paterno', const Icon(Icons.abc)),
                keyboardType: TextInputType.emailAddress,
                controller: regController.apPaterno,
                validator: (value){
                  return regController.validateField(value!, TypeInput.name);
                },
                onSaved: (value) {
                  regController.firstSur.value = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                    setInputStyles('Apellido materno', const Icon(Icons.abc)),
                keyboardType: TextInputType.name,
                controller: regController.apMaterno,
                validator: (value){
                  return regController.validateField(value!, TypeInput.name);
                },
                onSaved: (value) {
                  regController.secondSur.value = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
        
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: setInputStyles(
                    'Fecha de nacimiento', const Icon(Icons.date_range_outlined)),
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                onTap: () => _selectDate(context),
                controller: regController.fechaNa,   
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: regController.sexOptions
                      .map<DropdownMenuItem<Sex>>((Sex sex) {
                    return DropdownMenuItem<Sex>(
                      value: sex,
                      child: Text(sex.sexo),
                    );
                  }).toList(),
                  validator: (value){
                    return regController.validateDrop(value);
                },
                  onChanged: (value) {
                    if(value != null){
                      regController.sex.value = value.idSexo;
                    }
                 
                  },
                  decoration: setInputStyles(
                      'Sexo', const Icon(Icons.people_alt_outlined)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: regController.civilOptions
                      .map<DropdownMenuItem<CivilState>>((CivilState value) {
                    return DropdownMenuItem<CivilState>(
                      value: value,
                      child: Text(value.estadoCivil),
                    );
                  }).toList(),
                   validator: (value){
                    return regController.validateDrop(value);
                },
                  onChanged: (value) {
                    if(value != null){
                      regController.civilState.value = value.idEstadoCivil;
                    }
                    
                  },
                  decoration: setInputStyles(
                      'Estado civil', const Icon(Icons.diversity_1)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: regController.ocupationsOptions
                      .map<DropdownMenuItem<Ocupation>>((Ocupation value) {
                    return DropdownMenuItem<Ocupation>(
                      value: value,
                      child: Text(value.ocupacion),
                    );
                  }).toList(),
                   validator: (value){
                    return regController.validateDrop(value);
                },
                  onChanged: (value) {
                    if(value != null){
                       regController.ocupation.value = value.idOcupacion;
                    }
                  },
                  decoration: setInputStyles(
                      'Ocupación', const Icon(Icons.engineering_outlined)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
        
               Obx(
                () => DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  items: regController.residenceOptions
                      .map<DropdownMenuItem<Residence>>((Residence value) {
                    return DropdownMenuItem<Residence>(
                      value: value,
                      child: Text(value.domicilio),
                    );
                  }).toList(),
                   validator: (value){
                    return regController.validateDrop(value);
                },
                  onChanged: (value) {
                    if(value != null){
                       regController.residenceid.value = value.idTipoDomicilio;
                    }
                  },
                  decoration: setInputStyles(
                      'Tipo de domicilio', const Icon(Icons.home)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
        
              ExpandedButton(
                text: const Text("Continuar"),
                color: AppColors.primaryOrange,
                textMode: false,
                action: () {
                  final status = regController.checkRegister();
        
                  if (status == false) {
                    Get.snackbar(
                      'Error',
                      'Verifica los campos',
                      icon: const Icon(Icons.error),
                      backgroundColor: Colors.amberAccent,
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                   
                    Get.toNamed(Routes.account);
                  }
                },
              )
            ],
          ),
        ),
      
    );
  }

  Future<void> _selectDate(BuildContext context) async {

  
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      regController.bornDate.value = picked;
      regController.fechaNa.text = DateFormat('yyyy-MM-dd').format(picked);
    
    }
  }
}
