
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import '../../../../domain/models/seguimientos.dart';

class SeguimientoController extends GetxController{

  final UserRepository userRepository;
  RxList<Seguimiento> seguimientos = RxList();

  SeguimientoController({required this.userRepository});


  @override
  void onInit()async{
    super.onInit();
    seguimientos.value = await userRepository.getSeguimientosByuser();
  }


}