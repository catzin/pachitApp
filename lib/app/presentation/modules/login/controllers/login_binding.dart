import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/auth_repository.dart';
import 'package:pachitaapp/app/presentation/modules/login/controllers/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(authRepository: Get.find<AuthRepository>()));
  }
}