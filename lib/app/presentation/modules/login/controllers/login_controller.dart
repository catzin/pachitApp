import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/presentation/global_controllers/global_controller.dart';
import 'package:pachitaapp/app/presentation/routes/routes.dart';
import '../../../../domain/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  final globalController = Get.find<GlobalController>();
 
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  RxBool isSending  = false.obs;
 

  String email = "";
  String password = "";

  LoginController({required this.authRepository});

  String get emailInput => email;
  String get passInput => password;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose(){
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }


  String ? validateEmail(String value){
    if(!GetUtils.isEmail(value)){
      return 'email no válido';
    }

    return null;
  }

  String? validatePassword(String value){
    if(value.isEmpty){
      return 'Contraseña no válida';
    }
    return null;
  }

  bool checkLogin(){
    final isValid = loginFormKey.currentState!.validate();

    if(!isValid){
      return false;
    }
    loginFormKey.currentState!.save();
    return true;

   
  }

  Future<void> login(String email, String password)async{

    try{
      isSending.value = true;
      final res = await authRepository.loginWithEmail(email, password);
      isSending.value = false;
   
         Get.snackbar('¡Bienvenido!',res,
          icon: const Icon(Icons.face_2_outlined),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          );

      Get.offAllNamed(Routes.home);
     
    }catch(e){
      isSending.value = false;
      String error = "";

      switch (e) {
        case 'Not Found': error = "El usuario no existe"; break;
        case 'Unauthorized': error = "Correo o contraseña incorrectos";break;
        default: error = e.toString(); break;
      }

      Get.snackbar(
        'Error',
        error,
        icon: const Icon(Icons.error),
        backgroundColor: Colors.amberAccent,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<bool> loginWithGoogle()async{

    try{
      
      final response = await authRepository.loginWithGoogle();

      globalController.userGoogle.update((val) {
        val!.displayName= response!.displayName;
        val.email= response.email;
        val.photoURL= response.photoURL;
       });
       
      globalController.existUsergoogle.value = true;
       
      return true;

    }catch(e){
      e.printError();
      globalController.existUsergoogle.value = false;
      return false;
    }

   
  }


}
