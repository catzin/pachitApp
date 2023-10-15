import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import '../../../../domain/models/request_by_pet.dart';

class CandidateController extends GetxController {
  final UserRepository userRepository;

  RequestPet? argsRequest;
  int? idMascota;
  RxString shelterName = "".obs;


  @override
  void onInit(){
    super.onInit();
    initShelterName();
    Map<String, dynamic> data = Get.arguments;
    argsRequest = data['user'];
    idMascota = data['idmascota'];
  }

  CandidateController({required this.userRepository});

  void initShelterName()async{

    try{

      shelterName.value = "Huella por Huella";


    }catch(e){
      
      Get.snackbar('!Upppps!', 'Algo salio mal');
    }

  }

  Future<bool> generateContrate()async{

    try{

      String organitationName = "Huella por Huella";
      String adopter = argsRequest!.usuario.nombre;
      String additionalClause = "El adoptante se compromete a enviar fotos de seguimiento de la mascota adoptada periódicamente. El adoptante se compromete a cuidar de la mascota y brindarle un hogar amoroso y seguro.";

      final bool res = await userRepository.sendPDFContract(organitationName,adopter,additionalClause);
      return res;

    }catch(e){
      print(e.toString());
      return false;

    }

  }

  Future<bool> changeRequestStatus(int idSolicitud, int newStatus) async {
    try {
      await userRepository.changeStatusRequest(idSolicitud, newStatus);

      return true;
    } catch (e) {
      Get.snackbar('!Upppps!', 'Algo salió mal');
      return false;
    }
  }
}
