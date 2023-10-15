
import 'package:get/instance_manager.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import 'package:pachitaapp/app/presentation/modules/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(connectivityRepository: Get.find<ConnectivityRepository>(), authRepository: Get.find<AuthRepository>()));

  }

}