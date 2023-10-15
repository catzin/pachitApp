import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/models/status_request.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

class MotivesController extends GetxController{

  final UserRepository userRepository;
  final Solicitude args = Get.arguments;
  MotivesController({required this.userRepository});

  @override
  void onInit(){
    super.onInit();
    print(args.mascota.nombre);

  }

}