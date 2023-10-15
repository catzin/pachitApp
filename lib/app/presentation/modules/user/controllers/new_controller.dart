import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pachitaapp/app/domain/models/pet_register.dart';
import 'dart:io';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:pachitaapp/app/presentation/routes/routes.dart';

import '../../../../domain/models/index.dart';
class NewViewController extends GetxController {

  final petOptions = RxList<PetType>();
  final activityLevel = RxList<NivelActividad>();
  final caracts = RxList<CaracteristicasType>();
  final raza = RxList<RazaType>();
  final petAge = RxList<PetAgeResponse>();
  final petSex = ['MACHO','HEMBRA'].obs;
  final List<String >disableOptions = ['Sí, deshabilita','No, no es necesario'];

  RxList<CaracteristicasType> selectedChips = <CaracteristicasType>[].obs;

  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  late TextEditingController petNombre, petSexo, petTipo, petEdad, petRaza , petActividad, petDescripcion;
  
  final _image = Rxn<File>();
  final ImagePicker picker = ImagePicker();
  List<File>images = [];
  List<String>  listPathImages = List<String>.generate(3, (index) => '').obs;
  File? get image => _image.value;
  RxBool loadingPet = false.obs;
  RxInt disableSelected = 0.obs;


  final CatalogsRepository catalogsRepository;
  final UserRepository userRepository;

  final homeController = Get.find<HomeController>();

  NewViewController({required this.catalogsRepository, required this.userRepository});
  
  @override
  void onInit(){
    super.onInit();
    petNombre = TextEditingController();
    petSexo = TextEditingController();
    petTipo = TextEditingController();
    petEdad = TextEditingController();
    petRaza = TextEditingController();
    petActividad = TextEditingController();
    petDescripcion = TextEditingController();
    
  }

  @override
  void dispose(){
    super.dispose();
    petNombre.dispose();
    petSexo.dispose();
    petTipo.dispose();
    petEdad.dispose();
    petRaza.dispose();
    petActividad.dispose();
    petDescripcion.dispose();
  }

  @override
  void onReady(){
    super.onReady();
    getCatalogs();
  }


  void createNewPet()async{
    loadingPet.value = true;
    


    try {

      final List<int> idsCaracts = <int>[];
      for (var element in selectedChips) {
        idsCaracts.add(element.caracteristicaId);
      }

      PetRegister pet = PetRegister(
        name: petNombre.value.text,
        sexo: petSexo.value.text,
        tipo: petTipo.value.text,
        edad: int.parse(petEdad.value.text),
        tipoRaza: int.parse(petRaza.value.text),
        tipoActividad: int.parse(petActividad.value.text),
        status: 1,
        descripcion: petDescripcion.value.text,
        caracteristicas: idsCaracts,
        secureDisabled: disableSelected.value
      );

      final Pet resultPet =await userRepository.registerPet(pet,listPathImages);
      homeController.addPet(resultPet);
      loadingPet.value = false;
      Get.toNamed(Routes.home);

    } catch (e) {
      loadingPet.value = false;
      e.printError();
      
    }

  }


  void getCatalogs()async{
    try{

      petOptions.value = (await catalogsRepository.petType);
      activityLevel.value = (await catalogsRepository.activityLevels);
      caracts.value = (await catalogsRepository.caracteristicas);
      raza.value =  (await catalogsRepository.razas); 
      petAge.value = await catalogsRepository.petEdad;
     

    }catch(e){

      Get.snackbar('Error!', 'Algo salio mal :(',
          icon: const Icon(Icons.face_2_outlined),
          backgroundColor: Colors.amberAccent,
          duration: const Duration(seconds: 2),
          );

    }
  }




  Future<void> popImage(int index) async {
    listPathImages[index] = '';
  }

  void toggleChip(CaracteristicasType chip) {
    if (selectedChips.contains(chip)) {
      selectedChips.remove(chip);
    } else {
      selectedChips.add(chip);
    }
 
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

  
}
