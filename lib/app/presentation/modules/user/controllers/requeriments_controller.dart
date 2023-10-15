
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

import '../../../../domain/models/profile_adopt.dart';

class RequerimentsController extends GetxController{
  final UserRepository userRepository;

  Rx<ProfileAdopt> userInfo = ProfileAdopt(status: 0, message: "message", user: User.empty()).obs;
  RxBool isLoading = false.obs;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RequerimentsController({required this.userRepository});


  @override
  void onInit(){
    super.onInit();
    getUserAdoptInformation();
   
  }

   String caculateAgeUser(DateTime date){
  
    final DateTime bornDate = date;
    final DateTime hoy = DateTime.now();
    final Duration diff = hoy.difference(bornDate);
    final int edad = (diff.inDays / 365.25).floor();
    return ('$edad años.');
  }

  Future<bool> deleteContact(int index)async{

    final idReferencia = userInfo.value.user.contactosReferencia[index].idReferencia;
    userInfo.value.user.contactosReferencia.removeAt(index);

    try {
      await userRepository.deleteReference(idReferencia);
      return true;

    } catch (e) {
      e.printError();
      return false;

      
    }
   
    


  }

  void getUserAdoptInformation()async{
     isLoading.value = true;
    try {
      final ProfileAdopt res = await userRepository.searchInfoAdopt();

      userInfo.update((val) {
        val!.status = res.status;
        val.message = res.message;
        val.user = res.user;

      });

      userInfo.value.user.contactosReferencia = userInfo.value.user.contactosReferencia.where((contacto) => contacto.active != 0).toList();
      
      isLoading.value = false;
      
    } catch (e) {
      
      e.printError();
    }
  }
}