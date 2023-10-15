import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/shelter_controller.dart';
import 'package:pachitaapp/app/presentation/shared/index.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../routes/routes.dart';

class ReminderForm extends StatelessWidget {
  ReminderForm({super.key});

  final shelterController = Get.find<ShelterController>();

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    final startDate = DateTime(selectedDate.year,
        1); // Establecer el inicio del rango en enero del año actual
    final endDate = DateTime(selectedDate.year + 1,
        12); // Establecer el final del rango en diciembre del próximo año
    return Form(
      key: shelterController.reminderKey,
      child: Column(
        children: [
          TextFormField(
            controller: shelterController.titulo,
            onSaved: (value) => shelterController.titulo.text = value!,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.file),
              labelText: 'Titulo',
              hintText: 'Ingresa titulo',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: shelterController.descripcion,
            // validator: (value) => upgradeController.validateEmpty(value!),
            onSaved: (value) => shelterController.descripcion.text = value!,
            maxLines: 10,
            maxLength: 200,
            decoration: const InputDecoration(
              hintText: 'Escribe el recordatorio',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              const TextApp(
                  text: 'Establecer fecha del evento',
                  fontSize: 15,
                  weight: FontWeight.w500,
                  color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: ScrollDatePicker(
                  selectedDate: selectedDate,
                  minimumDate: startDate,
                  maximumDate: endDate,
                  options: DatePickerOptions(
                      backgroundColor: Colors.white.withOpacity(0.2)),
                  locale: const Locale('en'),
                  onDateTimeChanged: (DateTime value) {
                    shelterController.reminderDate.value =
                        value.toIso8601String();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() => shelterController.createCalendar.value || shelterController.createReminder.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ExpandedButton(
                  text: const Text("Crear"),
                  color: AppColors.primaryOrange,
                  textMode: false,
                  action: () async {
                    final result = await shelterController.createGoogleCalendarEvent();
              
                    if(result.isNotEmpty){
                      final created = await shelterController.registerReminder(result);
                      if(created){
                        Get.offAllNamed(Routes.home);
                      }

                    }
                  
         
                  },
                )
                
                )
        ],
      ),
    );
  }
}
