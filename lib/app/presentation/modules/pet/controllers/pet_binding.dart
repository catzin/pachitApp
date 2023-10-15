
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import 'package:pachitaapp/app/presentation/modules/pet/controllers/pet_controller.dart';
import 'package:pachitaapp/app/presentation/modules/pet/controllers/pet_profileController.dart';
import 'package:pachitaapp/app/presentation/modules/pet/controllers/pet_request_controller.dart';
import 'package:pachitaapp/app/presentation/modules/pet/controllers/pet_weekController.dart';

import 'spend_controller.dart';



class PetBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PetController(userRepository: Get.find<UserRepository>()));
    Get.lazyPut(() => PetWeekController());
    Get.lazyPut(() => PetProfileController( userRepository: Get.find<UserRepository>()));
    Get.lazyPut(() => SpendController(userRepository: Get.find<UserRepository>()));
    Get.lazyPut(() => PetRequestController(userRepository: Get.find<UserRepository>()));

  }

}