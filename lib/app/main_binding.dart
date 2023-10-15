
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'data/repos_implementations/auth_imp.dart';
import 'data/repos_implementations/calendar_imp.dart';
import 'data/repos_implementations/catalogs_imp.dart';
import 'data/repos_implementations/connectivity_imp.dart';
import 'data/repos_implementations/user_imp.dart';
import 'data/services/loca_notification_service.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/calendar_repository.dart';
import 'domain/repositories/catalogs_repostitory.dart';
import 'domain/repositories/connectivity_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'presentation/global_controllers/global_controller.dart';


const baseUrl ='http://192.168.1.76:3001/pachitaV1/';
final localNotifications = LocalNotificationService();
const secure =  FlutterSecureStorage();
class MainBinding extends Bindings{
  
  @override
  void dependencies() {
    Get.put(GetConnect());
    Get.put(GlobalController( localNotificationService: localNotifications));
    Get.lazyPut<UserRepository>(() => UserImp(baseUrl: baseUrl,secureStorage: secure),fenix: true);
    Get.lazyPut<AuthRepository>(() => AuthImp(secureStorage: secure, baseUrl: baseUrl),fenix: true);
    Get.lazyPut<ConnectivityRepository>(() => ConnectivityImp(connectivity: Connectivity()),fenix: true);
    Get.lazyPut<CatalogsRepository>(() => CatalogImp(baseUrl: baseUrl), fenix: true);
    Get.put<CalendarRepository>(CalendarRepositoryImp());

    
  }

}