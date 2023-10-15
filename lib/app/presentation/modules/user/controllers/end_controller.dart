import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

import '../../../../domain/models/request_by_pet.dart';

class EndController extends GetxController{

  final UserRepository userRepository;
  final RxString idorg = "".obs;
  FlutterSecureStorage saved = const FlutterSecureStorage();
  EndController({required this.userRepository});
  RxInt tiposeg = 0.obs;
  RxInt tiempo = 0.obs;

  RequestPet? argsRequest;
  int ? idmascota;

  @override
  void onInit(){
    super.onInit();
     Map<String, dynamic> data = Get.arguments;
    argsRequest = data['args'];
    idmascota = data['idmascota'];
   

  }

  @override
  void onReady(){
    super.onReady();
    getIdOrg();
  }

  Future<bool> createAdoption()async{

    try{

       Map<String, dynamic> data = {
        "idorganizacion": idorg.value,
        "idusuario": argsRequest!.usuario.idusuario,
        "idmascota": idmascota,
        "tipoSeguimiento": tiposeg.value,
        "fechaAdopcion": DateTime.now().toIso8601String(),
        "frecuencia": tiempo.value
      };

    final bool result = await userRepository.createAdoption(data);

    return result;

    }catch(e){
     return false;
    }


  }

  void getIdOrg()async{
    try{

      final id = await saved.read(key: 'id');
      idorg.value = await userRepository.getIdShelter(id!);
      print('idorg : ${idorg.value}');
     
      
    }catch(e){
      Get.snackbar('!Uppps!', 'Algo salió mal');
    }
  }



}