import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/models/index.dart';
import '../../../../domain/enums/index.dart';
import '../../../../domain/models/user_information.dart';
import '../../../../domain/repositories/index.dart';
import '../../../global_controllers/global_controller.dart';
import '../../../routes/routes.dart';



class RegisterController extends GetxController {
  final globalController = Get.find<GlobalController>();
  final CatalogsRepository catalogsRepository;
  final AuthRepository authRepository;
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> accountFormKey = GlobalKey<FormState>();
  late TextEditingController nombre, apPaterno, apMaterno, fechaNa;
  late TextEditingController correo, telefono, contrasena, confirm;
  final formSubmitted = false.obs;
  final sending = false.obs;

  var bornDate = DateTime.now().obs;
  RxString name = "".obs;
  RxString firstSur = "".obs;
  RxString secondSur = "".obs;
  RxInt sex = 0.obs;
  RxInt civilState = 0.obs;
  RxInt ocupation = 0.obs;
  RxInt residenceid = 0.obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString password = "".obs;
  RxString confirmpass = "".obs;

  final sexOptions = RxList<Sex>();
  final ocupationsOptions = RxList<Ocupation>();
  final civilOptions = RxList<CivilState>();
  final residenceOptions = RxList<Residence>();

  RegisterController({required this.catalogsRepository,required this.authRepository});
  get nameUSer => name.value;
  get born => fechaNa.value;

  RxBool existGoogleInfo = false.obs;
  var userGoogle = UserInformation().obs;

  @override
  void onInit() async {
    super.onInit();
    verifiryGoogleUser();
    nombre = existGoogleInfo.value ? TextEditingController(text: userGoogle.value.displayName!.split(' ')[0]) : TextEditingController(text:'');
    apPaterno = existGoogleInfo.value ? TextEditingController(text: userGoogle.value.displayName!.split(' ')[1]) :  TextEditingController(text:'');
    apMaterno = TextEditingController();
    fechaNa = TextEditingController();
    correo = existGoogleInfo.value ? TextEditingController(text: userGoogle.value.email) : TextEditingController();
    telefono = TextEditingController();
    contrasena = TextEditingController();
    confirm = TextEditingController();
    
  }

  
  @override
  void onReady() async {
    super.onReady();
    getCatalogs();
  
  }

  void verifiryGoogleUser(){
  
    if(globalController.existUsergoogle.value){
    
      existGoogleInfo.value = true;
      userGoogle = globalController.userGoogle;
    
   
    }
  }

  void getCatalogs()async{
    try{

      sexOptions.value = (await catalogsRepository.sex);
      ocupationsOptions.value = (await catalogsRepository.ocupations);
      civilOptions.value = (await catalogsRepository.civilState);
      residenceOptions.value = (await catalogsRepository.residence);

    }catch(e){

      Get.snackbar('Error!', e.toString(),
          icon: const Icon(Icons.face_2_outlined),
          backgroundColor: Colors.amberAccent,
          duration: const Duration(seconds: 2),
          );

    }
  }


  String? validateField(String value, TypeInput input) {

    final regex = RegExp(r'\d');
    final regexPass = RegExp(r'^(?=.*?[A-Z])(?=.*?\d)');
    String notEmptyMesage = "Por favor, rellena el campo";
    String emailMessage = "Verifica tu correo";

      switch (input) {
        case TypeInput.email:
          if (value.isEmpty) {
            return notEmptyMesage;
          } else if (GetUtils.isEmail(value)) {
            return null;
          } else {
            return emailMessage;
          }

        case TypeInput.password:
          if (value.isEmpty) {
            return notEmptyMesage;
          }
          if (GetUtils.isLengthLessThan(value, 8)) {
            return "Minimo 8 caracteres";
          }

          if (regexPass.hasMatch(value)) {
            return null;
          } else {
            return "Al menos una mayúscula y un número";
          }

        case TypeInput.name:
          if (GetUtils.isLengthLessThan(value, 3)) {
            return "Minimo 3 caracteres";
          }
          if (regex.hasMatch(value)) {
            return "Solo caracteres";
          }
          break;
        case TypeInput.passwordConfirm:
          if (value.isEmpty) {
            return notEmptyMesage;
          } else if (value != contrasena.text) {
            return "Las contraseñas no coinciden";
          } else {
            return null;
          }
        case TypeInput.phone:
          if(value.isEmpty){
            return notEmptyMesage;
          }
          if(GetUtils.isPhoneNumber(value)){
            return null;
          }
          return null;
      }
      return null;
    
  }

  String? validateEmpty(String value) {
    if (value.isEmpty) {
      return 'Por favor, rellena el campo';
    }

    return null;
  }

  String? validateDrop(dynamic value) {
    if (value == null) {
      return 'Elige una opción';
    }
   
    return null;
  }

  bool checkRegister() {

    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    else{
       formSubmitted.value = true;
       registerFormKey.currentState!.save();
      return true;
    }
   
  }

  Map<String, dynamic> buildNewUserBody() {

    DateTime today =  DateTime.now();
    String fechaString = today.toString();



    return {
      "nombre": name.value,
      "apellidoPaterno": firstSur.value,
      "apellidoMaterno": secondSur.value,
      "fechaNacimiento": bornDate.value.toString(),
      "fechaRegistro": fechaString,
      "correo": correo.value.text,
      "contrasena": contrasena.value.text,
      "fotoPerfil": "xxxxx",
      "linkFacebook": " ",
      "linkInstagram": " ",
      "estadoCivil_idEstadoCivil": civilState.value,
      "sexo_idSexo": sex.value,
      "ocupacion_idOcupacion": ocupation.value,
      "tipoUsuario_idTipoUsuario": 1,
      "Tipodomicilio_idTipoDomicilio": residenceid.value,
      "isactive": true,
      "telefono": telefono.value.text
    };
  }

  bool validateAccount() {
    final isValid = accountFormKey.currentState!.validate();

    if (isValid) {
      return true;
    }
    accountFormKey.currentState!.save();
    return false;
  }

  void createAccount()async{
    try {
      sending.value = true;
      final res = await authRepository.createAccount(buildNewUserBody());
      sending.value = false;
    
      Get.snackbar('¡Bienvenido!',res,
          icon: const Icon(Icons.face_2_outlined),
          backgroundColor: Colors.yellow,
          duration: const Duration(seconds: 2),
          );

      Get.offAllNamed(Routes.home);
     
      
    } catch (e) {
   
      sending.value = false;
      String error = "";

      switch (e) {
        case 'Not Found': error = "El usuario no existe"; break;
        case 'Unauthorized': error = "Correo o contraseña incorrectos"; break;
        default: error = '¡El correo ya esta en uso!';break;
      }

      Get.snackbar(
        'Upsss',
        error,
        icon: const Icon(Icons.error),
        backgroundColor: Colors.amberAccent,
        duration: const Duration(seconds: 2),
      );
      
    }
  }
}


