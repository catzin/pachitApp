
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import '../../../../domain/models/shelter.dart';

class FlowControlller extends GetxController{

  final UserRepository userRepository;

  FlowControlller({ required this.userRepository});

  Future<Shelter> getMySheltInfo()async{
    final data = await userRepository.findMyShelter();
    return data;
    
  }

  
}