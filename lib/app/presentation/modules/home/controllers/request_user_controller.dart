
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

class RequestUserController extends GetxController{

  final UserRepository userRepository;

  RequestUserController({ required this.userRepository});
  @override
  void onInit(){
    super.onInit();
    print('works');
  }


}