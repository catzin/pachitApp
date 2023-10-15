
import 'package:get/get.dart';

import '../../../../domain/models/request_by_pet.dart';
import '../../../../domain/repositories/user_repository.dart';

class PetRequestController extends GetxController{

  final idMascota = Get.arguments;

  RxList <RequestPet> persons = <RequestPet>[].obs;

  final UserRepository userRepository;

  PetRequestController({required this.userRepository});
  @override
  void onInit(){
    super.onInit();
    findPersons();
  }

  void findPersons()async{
    try{
      persons.value = await userRepository.requestByPet(idMascota);
    }catch(e){
      e.printError();
    }
  }
}