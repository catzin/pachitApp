
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import 'package:pachitaapp/app/presentation/modules/petition/controllers/petition_controller.dart';

class PetitionBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut(() => PetitionController( userRepository: Get.find<UserRepository>(), authRepository: Get.find<AuthRepository>()));
 
  }

}