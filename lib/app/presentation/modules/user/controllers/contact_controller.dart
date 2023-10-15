
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

class ContactController extends GetxController{

  final UserRepository userRepository;
  late final TextEditingController contact;
  RxBool uploadContact = false.obs;
  RxBool existHour = false.obs;

  ContactController({required this.userRepository});

  @override
  void onInit(){
    super.onInit();
    contact = TextEditingController();
    getDataHour();
  }

  @override
  void dispose(){
    contact.dispose();
    super.dispose();
  }

  void getDataHour()async{

    try{

      final Map<String, dynamic> data = await userRepository.getContactHour();

      if (data.isNotEmpty) {
     
        existHour.value = true;
        contact.text = data['especificacion'];
      }

    }catch(e){
      contact.text = " ";


    }
    

  }

  Future<bool> updateContactHour()async{
    try{

      uploadContact.value = true;
      final success = await userRepository.updateContactHour(contact.value.text);
      uploadContact.value = false;
      return success;

    }catch(e){
       uploadContact.value = false;
      Get.snackbar('Upss', e.toString());
      e.printError();
      return false;
    }
  }

  Future<bool> saveContactHour()async{

    try{
      uploadContact.value = true;
      final success = await userRepository.registerContactHour(contact.value.text);
      uploadContact.value = false;
      return success;

    }catch(e){
      uploadContact.value=false;
      Get.snackbar('Upss', e.toString());
      e.printError();
      return false;
      


    }
  }

}