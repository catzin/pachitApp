
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/category_controller.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/flow_controller.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/request_user_controller.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/search_pet_controller.dart';

import 'final_photo_controller.dart';
import 'motives_controller.dart';
import 'seguimiento_controller.dart';



class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(authRepo: Get.find<AuthRepository>(),userRepo: Get.find<UserRepository>()));
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => FlowControlller(userRepository: Get.find<UserRepository>()));
    Get.lazyPut(() => SearchPetController( userRepository: Get.find<UserRepository>()));
    Get.lazyPut(() => MotivesController( userRepository: Get.find<UserRepository>()));
    Get.lazyPut(() => SeguimientoController( userRepository: Get.find<UserRepository>()));
    Get.lazyPut(() => FinalPhotoController( userRepository: Get.find<UserRepository>()));
  }

}