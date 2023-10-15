import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/shared/index.dart';
import 'package:pachitaapp/app/presentation/shared/tittle_section.dart';
import '../../shared/text_app.dart';
import '../../theme/colors.dart';
import 'controllers/end_controller.dart';

class EndView extends StatelessWidget {
  EndView({super.key});
  final endController = Get.find<EndController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizar"),
        backgroundColor: HexColor(AppColors.primaryOrange),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children:[
              const TitleSection(title: "Finaliza la adopcion",subTitle: "Establece un seguimiento",icon: LineIcons.compassAlt,),
              const SizedBox(height: 20,),
              DropdownButtonFormField<String>(
                    // value: _opcionSeleccionada,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    
                    hint: const Text("Tipo de seguimiento"),
                    decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("Periodo")),
                    onChanged: (String? newValue)async{
                      endController.tiposeg.value = int.parse(newValue!);
                    },
                    items: <Map<String,dynamic>>[{'text' : 'Cada 7 días', 'id':1 }, {'text' : 'Cada 14 días', 'id':2},{'text' : 'Cada 30 días', 'id':3}]
                        .map<DropdownMenuItem<String>>((Map<String,dynamic> value) {
                      return DropdownMenuItem<String>(
                        value: value['id'].toString(),
                        child: Text(value['text']),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20,),
                  DropdownButtonFormField<String>(
                    // value: _opcionSeleccionada,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    
                    hint: const Text("¿Cuántas veces?"),
                    decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("Veces")),
                    onChanged: (String? newValue)async{
                      endController.tiempo.value = int.parse(newValue!);
                    },
                    items: <Map<String,dynamic>>[{'text' : '3 veces', 'id':3 }, {'text' : '5 veces', 'id':5},{'text' : '10 veces', 'id':10}]
                        .map<DropdownMenuItem<String>>((Map<String,dynamic> value) {
                      return DropdownMenuItem<String>(
                        value: value['id'].toString(),
                        child: Text(value['text']),
                      );
                    }).toList(),
                  ),

              const SizedBox(height: 30,),

              ExpandedButton(
                text: const Text("Finalizar"),
                color: AppColors.primaryOrange,
                textMode: false,
                action: ()async{
                  final bool res = await endController.createAdoption();

                  if(res){
                    Get.dialog(
                                
                                AlertDialog(
                                  
                                  title: const Text('Listo!',textAlign: TextAlign.center,),
                                  content: FractionallySizedBox(
                                    
                                    widthFactor: 0.8,
                                    heightFactor: 0.4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:   [
                                          TextApp(
                                          text:
                                              "Generamos las fechas de seguimiento para :${endController.argsRequest!.usuario.nombre} ${endController.argsRequest!.usuario.apellidoPaterno}",
                                          fontSize: 16,
                                          weight: FontWeight.bold,
                                          color: Colors.black,
                                          align: TextAlign.center,
                                        ),
                                        const Icon(
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
                                   
                                          // Cierra el modal
                                      },
                                      child: const Text('¡Listo!'),
                                    ),
                                  ],
                                ),
                      
                                barrierDismissible: false
                      
                              );
                  }
                },
              )
            ],
          ),
        ),
      ),

    );
  }
}