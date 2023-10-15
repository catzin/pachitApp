import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../presentation/routes/routes.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();


  Future<void>initNotifications()async{
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:(id, title, body, payload)async{
       
      },
    );


    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS
    );

    await notificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse:(NotificationResponse notificationResponse)async{
        if(notificationResponse.id == 0){
          Get.toNamed(Routes.createOrg);
        }
    },);
  }

  notificationDetails(){

    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max),
      iOS: DarwinNotificationDetails()
    );

  }

  Future showNotification({int id = 0, String ? title , String ? body , String ? payLoad})async{
    return notificationsPlugin.show(id, title, body, await notificationDetails());
  }

}
