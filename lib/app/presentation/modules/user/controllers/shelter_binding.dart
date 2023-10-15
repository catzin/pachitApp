
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/new_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/reference_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/requeriments_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/shelter_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/signature_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/upgrade_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/user_controller.dart';
import 'candidate_controller.dart';
import 'contact_controller.dart';
import 'documents_controller.dart';
import 'end_controller.dart';
import 'evidence_controller.dart';
import 'incidende_controller.dart';
import 'previus_pet.controller.dart';
import 'request_list_controller.dart';


class ShelterBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => SignaturesController(userRepository: Get.find<UserRepository>()));
    Get.lazyPut(
        () => ShelterController(
          calendarRepository: Get.find<CalendarRepository>(),
          userRepository: Get.find<UserRepository>(),
      ),
    );

    Get.lazyPut(() => UserController(catalogsRepository: Get.find<CatalogsRepository>() , userRepository:  Get.find<UserRepository>()));

    Get.lazyPut(() => NewViewController(

        catalogsRepository: Get.find<CatalogsRepository>(),
        userRepository: Get.find<UserRepository>(),
      ),
    );

    Get.lazyPut(() => RequerimentsController(userRepository: Get.find<UserRepository>()));
    
    Get.put(ReferenceController(userRepository:  Get.find<UserRepository>(),catalogsRepository: Get.find<CatalogsRepository>()));

    Get.lazyPut(
        () => UpgradeController(
          userRepository: Get.find<UserRepository>(),
      ),
    );

    Get.lazyPut(() => EvidenceController( userRepository:  Get.find<UserRepository>()));
    Get.lazyPut(() => ContactController( userRepository:  Get.find<UserRepository>()));
    Get.lazyPut(() => IncidenceController( userRepository:  Get.find<UserRepository>()));
    Get.lazyPut(() => RequestListController( userRepository:  Get.find<UserRepository>()));
    Get.lazyPut(() => DocumentsController( userRepository:  Get.find<UserRepository>()));
    Get.lazyPut(() => PreviusPetController( userRepository:  Get.find<UserRepository>()));
    Get.lazyPut(() => CandidateController( userRepository:  Get.find<UserRepository>()));
    Get.lazyPut(() => EndController(userRepository: Get.find<UserRepository>()));
  }
}

