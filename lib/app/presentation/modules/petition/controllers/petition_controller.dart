
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/models/index.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

class PetitionController extends GetxController{

  final UserRepository userRepository;
  final AuthRepository authRepository;
  final GlobalKey<FormState> petitionFormKey = GlobalKey<FormState>();
  late TextEditingController linkFacebookC, linkInstagramC,linkWebC, motivo;

  PetitionController({required this.userRepository, required this.authRepository});

  @override
  void onInit(){
    super.onInit();
    linkFacebookC = TextEditingController();
    linkInstagramC = TextEditingController();
    linkWebC = TextEditingController();
    motivo = TextEditingController();

   }

  @override
  void onClose(){
    // linkFacebookC.dispose();
    // linkInstagramC.dispose();
    // linkWebC.dispose();
    // motivo.dispose();
    super.onClose();
  }

  String ? validateLinkField(String value){
    if(value.isEmpty){
      return 'Rellena el campo';
    }
    if(!GetUtils.isURL(value)){
      return 'URL no válido';
    }

    return null;
  }

  bool validateAccount() {
    final isValid = petitionFormKey.currentState!.validate();

    if (isValid) {
      return true;
    }
    petitionFormKey.currentState!.save();
    return false;
  }

  Future<bool> sendRequest()async{

    final idUser = await authRepository.idUser; 
   
    Petition petition = Petition(
      idusuario: idUser,
      linkFacebook: linkFacebookC.value.text,
      linkInstagram: linkInstagramC.value.text,
      linkWeb: linkWebC.value.text,
      motivo: motivo.value.text,

    );

    try {
      final petitionResult = await userRepository.sendShelterRequest(petition);
      if(petitionResult.id.isNotEmpty){
        await userRepository.setPetition(petitionResult.id);
        return true;
        
      }

      return false;
      

    }catch (e){
      e.printError();
      return false;
    }


  }
  
}