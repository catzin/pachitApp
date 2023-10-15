
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

class RequestListController extends GetxController{
  final UserRepository userRepository;

  RequestListController({ required this.userRepository});

  @override
  void onInit(){
    super.onInit();

    print('works');
  }
}