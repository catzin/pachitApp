// ignore_for_file: file_names
import 'package:get/get.dart';

class PetWeekController extends GetxController{
  RxBool isReady = false.obs;
  
  
  @override
  void onReady(){
    super.onReady();
    delayed();

  }


  void delayed()async{
    isReady.value = false;
    await Future.delayed(const Duration(seconds: 2));
    isReady.value = true;
  }

}