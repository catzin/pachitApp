import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pachitaapp/app/domain/models/index.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import '../../home/controllers/home_controller.dart';

//controller for edit view screen, and user view
class UserController extends GetxController{
  
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  late TextEditingController facebook,instagram,fechaNa;
  final UserRepository userRepository;
  final CatalogsRepository catalogsRepository;
  final ImagePicker picker = ImagePicker();
 
  final userData = User(
    apellidoMaterno: '',
    apellidoPaterno: '',
    correo: '',
    telefono: '',
    documentos: [],
    mascotaPrevia: [],
    domicilio:[],
    contactosReferencia: [],
    estadoCivilIdEstadoCivil: EstadoCivilIdEstadoCivil(estadoCivil: '',idEstadoCivil: 0),
    fechaNacimiento: DateTime.now(),
    fechaRegistro: DateTime.now(),
    fotoPerfil: '',
    idusuario: '',
    linkFacebook: '',
    linkInstagram: '',
    nombre: '',
    ocupacionIdOcupacion: OcupacionIdOcupacion(idOcupacion: 0, ocupacion: ''),
    sexoIdSexo: SexoIdSexo(idSexo: 0, sexo: ''),
    tipoUsuarioIdTipoUsuario: TipoUsuarioIdTipoUsuario(idTipoUsuario: 0,usuario: ''),
    tipodomicilioIdTipoDomicilio: TipodomicilioIdTipoDomicilio(domicilio: '', idTipoDomicilio: 0),
  ).obs;
  
  var bornDate = DateTime.now().obs;

  final Rx<List<Sex>> sexOptions = Rx<List<Sex>>([]);
  final Rx<List<Ocupation>> ocupationsOptions = Rx<List<Ocupation>>([]);
  final Rx<List<CivilState>> civilOptions = Rx<List<CivilState>>([]);
  final Rx<List<Residence>> residenceOptions = Rx<List<Residence>>([]);


  final RxBool isLoading = false.obs;
  final RxBool changingImage = false.obs;
  final RxBool isUpdating = false.obs;


  RxInt sex = 0.obs;
  RxInt civilState = 0.obs;
  RxInt ocupation = 0.obs;
  RxInt residenceid = 0.obs;
  
  String pathProfile = "";


  final homeController = Get.find<HomeController>();

  UserController({required this.catalogsRepository,required this.userRepository});

  @override
  void onInit()async{

    super.onInit();
    getUserInfo();
    getCatalogs();
    facebook = TextEditingController();
    instagram = TextEditingController();
    fechaNa = TextEditingController();
   
  }

  @override
  void dispose(){
    super.dispose();
    facebook.dispose();
    instagram.dispose();
    fechaNa.dispose();

  }

   String get userEmail => userData.value.correo;
   DateTime get userRegisterDate => userData.value.fechaRegistro;

  String get userName {
    final nombre = userData.value.nombre;
    final apPaterno = userData.value.apellidoPaterno;
    final apMaterno = userData.value.apellidoMaterno;

    return '$nombre $apPaterno $apMaterno';
  }



  String caculateAgeUser(){
  
    final DateTime bornDate = userData.value.fechaNacimiento;
    final DateTime hoy = DateTime.now();
    final Duration diff = hoy.difference(bornDate);
    final int edad = (diff.inDays / 365.25).floor();
    return ('$edad años.');
  }
   void getCatalogs()async{
    try{
      isLoading.value = true;
      sexOptions.value = (await catalogsRepository.sex);
      ocupationsOptions.value = (await catalogsRepository.ocupations);
      civilOptions.value = (await catalogsRepository.civilState);
      residenceOptions.value = (await catalogsRepository.residence);

      isLoading.value = false;

    }catch(e){

      Get.snackbar('Error!', e.toString(),
          icon: const Icon(Icons.face_2_outlined),
          backgroundColor: Colors.amberAccent,
          duration: const Duration(seconds: 2),
          );
    }
  }


  Future<void> uploadImage()async{
    try {
      changingImage.value = true;
      final imgeResult = await userRepository.updateProfileImage(pathProfile);
       homeController.updateProfileImage(imgeResult);
      changingImage.value = false;
    } catch (e) {
      changingImage.value = false;
      e.printError();
    } 
  } 

  Future<void> getImageOne(int type) async {
    switch(type){
      case 0: 
        final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if(pickedFile != null){
          pathProfile = pickedFile.path;
          
          uploadImage();

        }
       

      break;
      case 1: 
        final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
        if(pickedFile != null){
          pathProfile = pickedFile.path;
          uploadImage();

        }
       
      break;
    }

  }  

  void getUserInfo() async {
  try {
    isLoading.value = true;
    final EditUser dataUser = await userRepository.getUsetInformation();

    userData.update((val) { 
      val!.nombre = dataUser.user.nombre;
      val.apellidoMaterno = dataUser.user.apellidoMaterno;
      val.apellidoPaterno = dataUser.user.apellidoMaterno;
      val.correo = dataUser.user.correo;
      val.estadoCivilIdEstadoCivil = dataUser.user.estadoCivilIdEstadoCivil;
      val.fechaNacimiento = dataUser.user.fechaNacimiento;
      val.fechaRegistro = dataUser.user.fechaRegistro; 
      val.fotoPerfil = dataUser.user.fotoPerfil;
      val.idusuario = dataUser.user.idusuario;
      val.linkFacebook = dataUser.user.linkFacebook;
      val.linkInstagram = dataUser.user.linkInstagram;
      val.ocupacionIdOcupacion =  dataUser.user.ocupacionIdOcupacion;
      val.sexoIdSexo =  dataUser.user.sexoIdSexo;
      val.tipoUsuarioIdTipoUsuario = dataUser.user.tipoUsuarioIdTipoUsuario;
      val.tipodomicilioIdTipoDomicilio =  dataUser.user.tipodomicilioIdTipoDomicilio;
      val.contactosReferencia = dataUser.user.contactosReferencia;
      val.mascotaPrevia = dataUser.user.mascotaPrevia;
      val.domicilio = dataUser.user.domicilio;
      val.documentos = dataUser.user.documentos;
      val.telefono = dataUser.user.telefono;
    });

    facebook.text = userData.value.linkFacebook.isEmpty ? '' : userData.value.linkFacebook;
    instagram.text = userData.value.linkInstagram.isEmpty ? '' : userData.value.linkInstagram;

    isLoading.value = false;
  } catch (e) {
    e.printError();
  }
}


Future<bool> updateInformation()async{
  isUpdating.value = true;
  try{

    final Map<String , dynamic> updateInfo = {
    "idusuario":"",
    "facebookLink":facebook.value.text,
    "instagramLink":instagram.value.text,
    "sexo_idSexo":userData.value.sexoIdSexo.idSexo,
    "estadoCivil_idEstadoCivil":userData.value.estadoCivilIdEstadoCivil.idEstadoCivil,
    "ocupacion_idOcupacion":userData.value.ocupacionIdOcupacion.idOcupacion,
    "Tipodomicilio_idTipoDomicilio":userData.value.tipodomicilioIdTipoDomicilio.idTipoDomicilio,


  };

   await userRepository.updateInfoUser(updateInfo);
   isUpdating.value = false;
   return true;



  }catch(e){
    e.printError();
    isUpdating.value = false;
    return false;


  }


  




}


  
  













  
}