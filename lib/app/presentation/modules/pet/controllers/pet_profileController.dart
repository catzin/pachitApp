// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/domain/models/adopt_request.dart';
import 'package:pachitaapp/app/domain/models/status_request.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import 'package:pachitaapp/app/presentation/global_controllers/global_controller.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';
import '../../../../domain/models/index.dart';
import 'package:pachitaapp/app/domain/models/pet.dart' as petimg;


class PetProfileController extends GetxController{

  final Pet info = Get.arguments;
  RxBool isLoading = false.obs;
  final images = RxList<MascotaImg>();
  final globalController = Get.find<GlobalController>();
  var likes = 0.obs;
  RxBool loadingImages = false.obs;
  RxBool isLiked = false.obs;
  RxBool isSendingAdoptResquest = false.obs;

  late TextEditingController motivosEditing;

  final UserRepository userRepository;

  PetProfileController({required this.userRepository});

  @override
  void onInit()async{
    super.onInit();
    isLoading.value = true;
    loadingImages.value = true;
    await Future.delayed( const Duration(milliseconds: 100));
    images.addAll(info.mascotaImgs);
    loadingImages.value = false;
    isLoading.value = false;
    motivosEditing = TextEditingController();

  }

  @override
  void onReady(){
    super.onReady();
    isLikedPet();
    initialLikes();
  }

  String get petName => info.nombre;
  bool get isShlelter => globalController.isShelter.value;

  void isLikedPet(){
    final result = globalController.favoritePets.any((element) => element.id == info.id);
    isLiked.value = result;
  }
  void likePet()async{
    try{

      Pet pet = await userRepository.likePet(info.id);
      likes.value++;
      isLiked.value = true;
      globalController.favoritePets.add(pet);
      Get.snackbar('¡Mascota Likeada!', 'Agregado a favoritos',colorText: Colors.white, backgroundColor: Colors.red);

    }catch(e){
      Get.snackbar('Upsss', e.toString());

    }
    
  }

  void initialLikes()async{
    try {
      likes.value = await userRepository.likesPet(info.id);
      
    } catch (e) {
      e.printError();
    }
  }

  void dislike()async{

    try{
      await userRepository.dislikePet(info.id);
      likes.value--;
      isLiked.value = false;
      globalController.favoritePets.removeWhere((element) => element.id == info.id);
      Get.snackbar('¡Dislike!', 'Eliminada de favoritos',colorText: Colors.black, backgroundColor: HexColor(AppColors.primaryOrange));
    }catch(e){
      Get.snackbar('Upsss', e.toString());

    }
   
  }
  
  Future<bool> sendPetition()async{

    try{

      isSendingAdoptResquest.value = true;
      if (globalController.isShelter.isTrue) {
        isSendingAdoptResquest.value = false;
        return false;
      }

      final Map<String, dynamic> data = {
        "fechaSolicitud": DateTime.now().toIso8601String(),
        "mascota": info.id,
        "usuario": "",
        "motivo": motivosEditing.value.text
      };

     
      final AdoptionRequest res = await userRepository.sendAdoptRequest(data);
   
      globalController.petitions.add(res);
      isSendingAdoptResquest.value = false;

    }catch(e){
       isSendingAdoptResquest.value = false;
      Get.snackbar('!Upsssss!', e.toString());

    }
  
    return true;
    
  }

}