import 'package:get/get.dart';
import '../../data/services/loca_notification_service.dart';
import '../../domain/models/adopt_request.dart';
import '../../domain/models/adoption_org.dart';
import '../../domain/models/pet.dart';
import '../../domain/models/status_request.dart';
import '../../domain/models/user_information.dart';

class GlobalController extends GetxController{
  final LocalNotificationService localNotificationService;
  RxBool isShelter = false.obs;
  RxList<Pet> favoritePets = <Pet>[].obs;
  RxList<PetOrgRequest> requestOrg = <PetOrgRequest>[].obs;
 
  RxList<Solicitude> requestUser = <Solicitude>[].obs;
  RxList<AdoptionRequest> petitions = <AdoptionRequest>[].obs;
  var userGoogle = UserInformation().obs;
  RxBool existUsergoogle = false.obs;
  RxList requestNames = [].obs;
  GlobalController({required this.localNotificationService});


  @override
  void onInit(){
    super.onInit();
    localNotificationService.initNotifications();
  }

  void showNotificationShelterAccpet()async{
   // await localNotificationService.showNotification();
    await localNotificationService.showNotification(id: 0, title: 'Notificacion', body: 'Felicidades tu solicitud fue aprobada');
  }

  void showNotificationExistRequest()async{
    await localNotificationService.showNotification(id: 1, title: 'Notificacion', body: 'Tienes nuevas solicitudes');
  }

   void reset() {

    isShelter.value = false;
    favoritePets.clear();
    petitions.clear();
    requestUser.clear();
    requestOrg.clear();
    requestNames.clear();
    userGoogle.value = UserInformation(); 
    existUsergoogle.value = false;

  
  }

  

}