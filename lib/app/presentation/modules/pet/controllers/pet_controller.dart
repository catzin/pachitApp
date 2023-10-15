
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

import '../../../../domain/models/index.dart';

class PetController extends GetxController{

  final String type = Get.arguments;
  final UserRepository userRepository;
  RxList<Pet> petList = <Pet>[].obs;
  RxBool isLoading = true.obs;
  RxInt option = 0.obs;

  PetController({required this.userRepository});

  @override
  void onReady() {
    getPetsByType();
    super.onReady();
  }

  void resetFilters()async{

    try{
      petList.value = [];
      petList.value = await userRepository.getPetsByType(type);


    }catch(e){
      e.printError();
    }

  }

  void getPetsByAge(int option)async{

    try{
      petList.value = [];
      petList.value = await userRepository.getPetsByAge(option, int.parse(type));

    }catch(e){
      e.printError();
    } 

  }


  void getPetsByActivity(int option)async{

    try{
      petList.value = [];
      petList.value = await userRepository.getPetsByActivity(option,int.parse(type));

    }catch(e){
      e.printError();
    }

  }

  void getPetsByType()async{

    try {
      petList.value  = await userRepository.getPetsByType(type);
      isLoading.value = false;
      
    } catch (e) {

      Get.snackbar('Error!', e.toString(),
          icon: const Icon(Icons.face_2_outlined),
          backgroundColor: Colors.amberAccent,
          duration: const Duration(seconds: 2),
          );
      
    }
  }



  
  
}