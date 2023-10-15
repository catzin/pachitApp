
import 'package:get/get.dart';
import '../../../../domain/repositories/index.dart';
import 'register_controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(
      catalogsRepository: Get.find<CatalogsRepository>(),
      authRepository: Get.find<AuthRepository>(),
    ),
  
    );
  }
}