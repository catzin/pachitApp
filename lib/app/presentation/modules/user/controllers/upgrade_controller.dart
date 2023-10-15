
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pachitaapp/app/domain/models/index.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import 'package:pachitaapp/app/presentation/global_controllers/global_controller.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/home_controller.dart';

import '../../../routes/routes.dart';

class UpgradeController extends GetxController{

  final isSending = false.obs;
  final ImagePicker picker = ImagePicker();
  List<String> listPathImages = List<String>.generate(2, (index) => '').obs;


  final GlobalKey<FormState> orgKey = GlobalKey<FormState>();
  late TextEditingController nombreOrg, deescripcion, linkDonacion;

  final UserRepository userRepository;
  final homeController = Get.find<HomeController>();
  final globalController = Get.find<GlobalController>();

  UpgradeController({required this.userRepository});

  @override
  void onInit(){
    super.onInit();
    nombreOrg = TextEditingController();
    deescripcion = TextEditingController();
    linkDonacion = TextEditingController();
  }

  String ? validateEmpty(String value){
    if(value.isEmpty){
      return 'Rellena el campo';
    }
    return null;
  }

  bool validateAccount() {
    final isValid = orgKey.currentState!.validate();

    if (isValid) {
      return true;
    }
    orgKey.currentState!.save();
    return false;
  }

  Future<void> popImage(int index) async {
  
  }

  Future<void> getImageOne(int index, int type) async {
    switch(type){
      case 0: 
        final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
        listPathImages[index] = pickedFile!.path;
       
       
      break;
      case 1: 
        final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
        listPathImages[index] = pickedFile!.path;
      break;
    }

  }

  void createOrganization()async{

    isSending.value = true;
    
    try {
      
      Organization data = Organization(
        nombre: nombreOrg.value.text,
        descripcion: deescripcion.value.text,
        fechaCreacion: DateTime.now(),
        linkDonacion: linkDonacion.value.text,
      );
      
      final shelter = await userRepository.createShelter(data,listPathImages);
      homeController.addShelter(shelter);
      globalController.isShelter.value = true;
      isSending.value = false;

      // Get.snackbar(
      //   'Éxito',
      //   'Organización creada correctamente',
      //   backgroundColor: Colors.yellow,
      //   duration: const Duration(seconds: 2),
      // );
      Get.toNamed(Routes.home);

    } catch (e) {
      e.printError();
      isSending.value = false;
      //Map<String, dynamic> responseMap = jsonDecode(e.toString());
      Get.snackbar(
        'Error',
        'Ocurrio un error',
        backgroundColor: Colors.yellow,
        duration: const Duration(seconds: 2),
      );
     
      
    }
    


  }
}

