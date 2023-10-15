
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';



class IncidenceController extends GetxController{

  final UserRepository userRepository;
  RxBool uploadIncidence = false.obs;
  final int petID = Get.arguments;

  IncidenceController({required this.userRepository});

  late final TextEditingController date,gasto,motivo;

  @override
  void onInit(){
    super.onInit();
    date =  TextEditingController();
    gasto =  TextEditingController();
    motivo =  TextEditingController();
  
  }

  Future<bool> sendInfo()async{

    try{
      uploadIncidence.value = true;
      final dateVal = DateTime.parse(date.value.text).toIso8601String();
      Map<String, dynamic> dataInfo = {
        "idmascota": petID,
        "gasto": double.parse(gasto.value.text),
        "motivo": motivo.value.text,
        "fecha": dateVal
      };

      await userRepository.registerIncidence(dataInfo);
      uploadIncidence.value = false;

      return true;

    }catch(e){
      e.printError();
      uploadIncidence.value = false;
      return false;

    }
    


  

  
  }

}