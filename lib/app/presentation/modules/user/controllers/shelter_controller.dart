
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import '../../../../domain/models/index.dart';
import '../../../../domain/models/recordatorio.dart';
import '../../../global_controllers/global_controller.dart';


class ShelterController extends GetxController{


  final Shelter data = Get.arguments;
  RxList<Pet> petList = <Pet>[].obs;
  RxBool isLoading = true.obs;
  RxBool reminderLoading = false.obs;

  final UserRepository userRepository;
  final CalendarRepository calendarRepository;

  RxList<Recordatorio> reminders = <Recordatorio>[].obs;
  var reminderDate = "".obs;

  final GlobalKey<FormState> reminderKey = GlobalKey<FormState>();
  final globalController = Get.find<GlobalController>();

  late TextEditingController titulo, descripcion;
  RxBool createCalendar = false.obs;
  RxBool createReminder = false.obs;
  RxBool isMyShelter = false.obs;

  ShelterController({required this.userRepository, required this.calendarRepository});
   

  @override
  void onInit(){
    
    super.onInit();
    titulo = TextEditingController();
    descripcion = TextEditingController();
    verifyShelter();
  }

  @override
  void onReady(){
    super.onReady();
    getPets();
  }

  void verifyShelter()async{ 

    if(globalController.isShelter.value){
       String shelterName =  await userRepository.isMyShelter();
      if(shelterName == data.nombre){
        isMyShelter.value = true;
        getReminders();
      }
      else{
        isMyShelter.value = false;
      }

    }

  }

  void getReminders()async{
    reminders.value = await  userRepository.listReminders( data.idorganizacion);
  
  }

  void addReminder(Recordatorio record){
    reminders.add(record);
  }


  Future<bool> registerReminder(String url)async{
    
    try{



      createReminder.value = true;
    
       Map<String, dynamic> datas = {
        "titulo":titulo.value.text,
        "descripcion":descripcion.value.text,
        "fechaCreacion": DateTime.now().toIso8601String(),
        "fechaEvento": DateTime.parse(reminderDate.value).toIso8601String(),
        "link":url,
        "organizacion_idorganizacion":data.idorganizacion

      };

      print(datas);

      await userRepository.createReminder(datas);

      createReminder.value = false;

      return true;

    }catch(e){
      createReminder.value = false;
      e.printError();
      return false;
    }

  }


  Future<String> createGoogleCalendarEvent()async{
    
    try {

     
      createCalendar.value = true;
      DateTime date = DateTime.parse(reminderDate.value);
      final String url = await calendarRepository.createReminderInCalendar(titulo.value.text, descripcion.value.text, date);

      createCalendar.value = false;
      return url;
    
      
    } catch (e) {
      e.printError();
      createCalendar.value = false;
      return ' ';

    }
  }


  void getPets()async{

    try {
      petList.value  = await userRepository.getPetsByShelter(data.idorganizacion);

      isLoading.value = false;
      
    } catch (e) {
    
      Get.snackbar('Error!', e.toString(),
          icon: const Icon(Icons.face_2_outlined),
          backgroundColor: Colors.amberAccent,
          duration: const Duration(seconds: 2),
          );
      
    }

  
  }


  
}