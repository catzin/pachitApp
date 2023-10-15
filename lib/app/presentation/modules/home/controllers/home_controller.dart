import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/domain/models/index.dart';
import '../../../../domain/models/adoption_org.dart';
import '../../../../domain/models/status_request.dart';
import '../../../../domain/repositories/index.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../global_controllers/global_controller.dart';
import '../../../theme/colors.dart';


class HomeController extends GetxController {
  final AuthRepository authRepo;
  final UserRepository userRepo;

  final position = Rx<Position?>(null);
  RxBool isShelter = false.obs;
  RxString activeUSer = "".obs;
  RxBool createOrgFlag = true.obs;
  RxString avatar = "".obs;
  RxBool isLoading = true.obs;
  RxBool readyPicture = false.obs;
  final categoryList = ["Gatos", "Perros"].obs;
  RxList<Pet> petList = <Pet>[].obs;
  RxList<Shelter> shelterList = <Shelter>[].obs;

  HomeController({required this.userRepo, required this.authRepo});
  RxBool showFloating = false.obs;
  RxBool existPetition = true.obs;
  RxBool loadingPets = false.obs;

  final global = Get.find<GlobalController>();

  @override
  void onInit() {
    super.onInit();
    getLocation();
    verifyPetition();
    verifyShelter();
    findUserRequest();
  }

  @override
  void onReady() async {
    super.onReady();
    activeUSer.value = await authRepo.currentUser;
    getPets();
    getShelterList();
    getProfilePicture();
    favoritePets();

    isLoading.value = false;
  }

  void findUserRequest() async {
    try {
      final result = await userRepo.isShelterUser();
      if (int.parse(result) == 2) {
        final List<PetOrgRequest> data = await userRepo.findPetsWithRequest();
        global.requestOrg.addAll(data);
        isShelter.value = true;
      } else {
        isShelter.value = false;
        final List<Solicitude> data = await userRepo.findUserRequest();
       
        global.requestUser.addAll(data);
      }
    } catch (e) {
      e.printError();
    }
  }

  void favoritePets() async {
    final petsLiked = await userRepo.favoritePets();
    global.favoritePets.addAll(petsLiked);
  }

  void addShelter(Shelter shelter) {
    shelterList.add(shelter);
  }

  void addPet(Pet pet) {
    petList.add(pet);
  }

  void updateProfileImage(String image) {
    avatar.value = image;
  }

  void getProfilePicture() async {
    readyPicture.value = false;
    try {
      final String image = await userRepo.getUserImageProfile();
     
      if (image.contains('https')) {
        avatar.value = image;
        readyPicture.value = true;
      } else {
        avatar.value =
            "https://pachstorage.s3.amazonaws.com/avatar_profile.png";
        readyPicture.value = true;
      }
    } catch (e) {
      e.printError();
    }
  }

  void verifyShelter() async {
    final result = await userRepo.isShelterUser();

    if (int.parse(result) == 2) {
      global.isShelter.value = true;
    } else {
      global.isShelter.value = false;
    }
  }

  void sendNotification() {
  
    global.showNotificationShelterAccpet();
  }

  void verifyPetition() async {
   
  
    final petition = await userRepo.hasPetition();
  
    if (petition) {
      Timer.periodic(const Duration(seconds: 10), (timer) async {
        try {
          final statusResponse = await userRepo.checkPetition();
          final status = statusResponse.result.estatus;
          final ended = statusResponse.result.finalizada;

        
          if (status) {
            if (ended == false) {
              sendNotification();
              timer.cancel();
            }
          }
        } catch (e) {
          e.printError();
        }
      });
    }
  }

  // ignore: invalid_use_of_protected_member
  get categoryLen => categoryList.length;

  Future<void> getLocation() async {
    final hasAddress = await userRepo.verifyAddress();

    

    // final status = await Permission.location.request();
    // print(status);

    if (hasAddress != null) {
      //Get.snackbar('Ubicación', 'Ubicación actualizada');
    } else {
      
      final permission = await Geolocator.requestPermission();

      if (LocationPermission.whileInUse == permission) {
        Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        position.value = pos;

        final lat = position.value!.latitude.toString();
        final lon = position.value!.longitude.toString();

        final Placemark? addressResponse = await userRepo.getAddres(lat, lon);

        if (addressResponse != null) {
          final Map<String, dynamic> dataAddress = {
            "street":
                addressResponse.street!.isEmpty ? "x" : addressResponse.street,
            "ISOCountryCode": addressResponse.isoCountryCode!.isEmpty
                ? "x"
                : addressResponse.isoCountryCode,
            "PostalCode": addressResponse.postalCode!.isEmpty
                ? "x"
                : addressResponse.postalCode,
            "administrativeArea": addressResponse.administrativeArea!.isEmpty
                ? "x"
                : addressResponse.administrativeArea,
            "subadministrativeArea":
                addressResponse.subAdministrativeArea!.isEmpty
                    ? "x"
                    : addressResponse.subAdministrativeArea,
            "locality": addressResponse.locality!.isEmpty
                ? "x"
                : addressResponse.locality,
            "sublocality": addressResponse.subLocality!.isEmpty
                ? "x"
                : addressResponse.subLocality,
            "thoroughfare": addressResponse.thoroughfare!.isEmpty
                ? "x"
                : addressResponse.thoroughfare,
            "Subthoroughfare": addressResponse.subThoroughfare!.isEmpty
                ? "x"
                : addressResponse.subThoroughfare,
            "lat": lat,
            "lon": lon,
          };

          await userRepo.registerAddress(dataAddress);
        }
      }

    }
  }

  void logOut() {
    global.reset();
    authRepo.logOut();

  }

  void getPets() async {
    loadingPets.value = true;
    try {
      petList.value = await userRepo.getAllPets();

      loadingPets.value = false;
    } catch (e) {
      loadingPets.value = false;
      Get.snackbar(
        'Error!',
        e.toString(),
        icon: const Icon(Icons.face_2_outlined),
        backgroundColor: Colors.amberAccent,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void getShelterList() async {
    try {
      shelterList.value = await userRepo.getShelters();
    } catch (e) {
      Get.snackbar(
        'Error!',
        e.toString(),
        icon: const Icon(Icons.face_2_outlined),
        backgroundColor: Colors.amberAccent,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<bool> dislikePetView(int idMascota) async {
    try {
      await userRepo.dislikePet(idMascota);
      global.favoritePets.removeWhere((element) => element.id == idMascota);
      return true;
    } catch (e) {
      Get.snackbar(
        'Upss!', // Título
        e.toString(), // Mensaje
        icon: const Icon(Icons.error, color: Colors.red), // Icono
        snackPosition: SnackPosition.BOTTOM, // Posición
        backgroundColor: HexColor(AppColors.primaryOrange), // Color de fondo
        colorText: Colors.black, // Color del texto
      );

      return false;
    }
  }
}
