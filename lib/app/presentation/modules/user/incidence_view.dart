
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import 'package:pachitaapp/app/presentation/shared/tittle_section.dart';

import '../../shared/text_app.dart';
import '../../theme/colors.dart';
import 'controllers/incidende_controller.dart';

class IncidenceView extends StatelessWidget {
  IncidenceView({super.key});

  final incidenceController = Get.find<IncidenceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Nueva incidencia",textAlign: TextAlign.center,),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children:[
  
            const TitleSection(title: 'Registra un gasto', subTitle: 'involucrado con el rescate', icon: LineIcons.moneyBill),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const TextApp(
                  text: 'Gasto realizado',
                  fontSize: 15,
                  weight: FontWeight.w500,
                  color: Colors.black,
                  align: TextAlign.start,
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: incidenceController.gasto,
                  textInputAction: TextInputAction.done,
                  keyboardType:TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Gasto',
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const TextApp(
                  text: 'Motivo',
                  fontSize: 15,
                  weight: FontWeight.w500,
                  color: Colors.black,
                  align: TextAlign.start,
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: incidenceController.motivo,
                  decoration: const InputDecoration(
                    labelText: 'Vacuna, alimento, etc',
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),


            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                
                const TextApp(
                  text: 'Fecha',
                  fontSize: 15,
                  weight: FontWeight.w500,
                  color: Colors.black,
                  align: TextAlign.start,
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: incidenceController.date,
                  readOnly: true,
                  onTap: (){
                    _selectDate(context);
                  },
                  decoration: const InputDecoration(
                    labelText: '¿Que dia?',
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            Obx(()=> incidenceController.uploadIncidence.value ? Center(child: CircularProgressIndicator(color: HexColor(AppColors.primaryOrange)),)  :
              ExpandedButton(
                text: const Text("Crear"),
                color: AppColors.primaryOrange,
                textMode: false,
                action: ()async{
                
                  final result = await incidenceController.sendInfo();
                  if (result) {
                    Get.dialog(
                      AlertDialog(
                        title: const Text("Gasto registrado"),
                        content: const Text("Ha sido registrada la incidencia"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Get.back(); 
                              Get.back(); 
                            },
                            child: const Text("Aceptar"),
                          )
                        ],
                      ),
                      barrierDismissible: false, 
                    );
                    
                  }
                  else{
                    Get.snackbar('!Upsss!', 'Algo salió mal');
                  }
            
                 
            
                  
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {

  DateTime now = DateTime.now();
  
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: now, 
    firstDate: now, 
    lastDate: DateTime(2101), 
  );
  
  if (picked != null && picked != now){
     incidenceController.date.text = DateFormat('yyyy-MM-dd').format(picked);

  }

   

}
}