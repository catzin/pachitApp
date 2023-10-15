
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import '../../../routes/routes.dart';

class SplashController extends GetxController{

  final ConnectivityRepository connectivityRepository;
  final AuthRepository authRepository;

  SplashController({required this.connectivityRepository,required this.authRepository});

  @override
  void onReady(){
    checkConnection();
    super.onReady();
  }

  void checkConnection()async{
     final hasConnection = await connectivityRepository.hasInternet;
     final existData = await authRepository.isSignIn;
     
     if(hasConnection && existData){
      Get.offNamed(Routes.home);
     }
     else{
      Get.offNamed(Routes.start);
     }

  }
  
}