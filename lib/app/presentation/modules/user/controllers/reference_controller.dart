

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/models/parentesco_item.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
class ReferenceController extends GetxController{

  final UserRepository userRepository;
  final CatalogsRepository catalogsRepository;
  RxBool isSending = false.obs;
  final GlobalKey<FormState> referenceKey = GlobalKey<FormState>();
  late TextEditingController nombre, apPaterno, apMaterno, telefono;
  RxInt parentId = 0.obs;
  RxBool isLoading = false.obs;

  RxList<ParentescoItem> parentescos = RxList<ParentescoItem>();

  ReferenceController({required this.userRepository, required this.catalogsRepository});
  
  @override
  void onInit(){
    super.onInit();
    nombre = TextEditingController();
    apPaterno = TextEditingController();
    apMaterno = TextEditingController();
    telefono = TextEditingController();
    getParentescos();
  }

  void getParentescos()async{
     parentescos.value = await catalogsRepository.parentescos;
  }

  Future<bool> createReference()async{

    try{

        isLoading.value = true;
    Map<String ,dynamic> dataSend = {
      "nombre": nombre.value.text,
      "apellidoPaterno":apPaterno.value.text,
      "apellidoMaterno":apMaterno.value.text,
      "telefono":telefono.value.text,
      "idParentesco":parentId.value,
      "active":1,
    };

    await userRepository.createRefence(dataSend);
    isLoading.value = false;
    return true;



    }catch(e){
      isLoading.value = false;
      e.printError();
      return false;
      

    }
    
  

    

 
  }


}