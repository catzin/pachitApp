
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/user_repository.dart';

class SignaturesController extends GetxController{

  final UserRepository userRepository;
  RxBool uploading = false.obs;

  SignaturesController({required this.userRepository});

  void signature(Uint8List signatureImage)async{
    try{
      uploading.value = true;
      await userRepository.signature(signatureImage);
      uploading.value = false;
      Get.back();

    }catch(e){
      uploading.value = false;
      Get.snackbar('!Upsss!', e.toString());
    }
  }
}