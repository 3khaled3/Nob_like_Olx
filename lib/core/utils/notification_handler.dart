import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static void handleFgNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      print(remoteMessage.notification!.title);
      print(remoteMessage.notification!.body);
      print(remoteMessage.data);
      showNotification(remoteMessage);
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      print(remoteMessage.notification!.title);
      print(remoteMessage.notification!.body);
      print(remoteMessage.data);
      showNotification(remoteMessage);
    });
  }

  static void showNotification(RemoteMessage remoteMessage) {
    FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon');
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    plugin.initialize(initializationSettings);
    String channelId  =  'p8';
    String channelName = 'android_p8';
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, channelName,
            priority: Priority.high,
            importance: Importance.high,
            autoCancel: true,
            ticker: 'Message received');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    plugin.show(remoteMessage.hashCode, remoteMessage.notification!.title,
        remoteMessage.notification!.body, notificationDetails);
  }
}

Future<void> bgNotificationHandler(RemoteMessage remoteMessage) async {
  print(remoteMessage.notification!.title);
  print(remoteMessage.notification!.body);
  NotificationHandler.showNotification(remoteMessage);
}



// class NotificationHandlr {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static void initialize() {
//     final initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
// //  String channelId =  'p8';
// //     String channelName = 'android_p8';
//   static void showLocalNotification({required String title, required String body}) async {
//     const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      
//       'p8', // Use a unique channel ID
//       'android_p8',
//       // 'Your Channel Description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'Message received',
//     );
//     const platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       title.hashCode, 
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'item x', // You can provide a payload if needed
//     );
//   }
// }
