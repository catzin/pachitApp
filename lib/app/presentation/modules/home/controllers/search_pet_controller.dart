
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import '../../../../domain/models/pets_user.dart';

class SearchPetController extends GetxController{
  
  final UserRepository userRepository;
  RxList<PetU> petList = <PetU>[].obs;
  SearchPetController({ required this.userRepository});
  RxInt selectedPet = 0.obs;

  @override
  void onInit(){
    super.onInit();
    getPets();
  }


   void getPets()async{

    try {
      petList.value  = await userRepository.listPetsOrganizationByUser();
      
    } catch (e) {
    
      Get.snackbar(
        'Error!',
        e.toString(),
        icon: const Icon(Icons.face_2_outlined),
        backgroundColor: Colors.amberAccent,
        duration: const Duration(seconds: 2),
      );
      
    }

  
  }
}