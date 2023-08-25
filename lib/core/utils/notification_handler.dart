// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationHandler {
//   static void handleFgNotifications() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
//       print(remoteMessage.notification!.title);
//       print(remoteMessage.notification!.body);
//       print(remoteMessage.data);
//       showNotification(remoteMessage);
//     });


//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
//       print(remoteMessage.notification!.title);
//       print(remoteMessage.notification!.body);
//       print(remoteMessage.data);
//       showNotification(remoteMessage);
//     });
//   }

//   static void showNotification(RemoteMessage remoteMessage) {
//     FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
//     AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('app_icon');
//     InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitializationSettings);
//     plugin.initialize(initializationSettings);
//     String channelId  =  'p8';
//     String channelName = 'android_p8';
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(channelId, channelName,
//             priority: Priority.high,
//             importance: Importance.high,
//             autoCancel: true,
//             ticker: 'Message received');
//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     plugin.show(remoteMessage.hashCode, remoteMessage.notification!.title,
//         remoteMessage.notification!.body, notificationDetails);
//   }
// }

// Future<void> bgNotificationHandler(RemoteMessage remoteMessage) async {
//   print(remoteMessage.notification!.title);
//   print(remoteMessage.notification!.body);
//   NotificationHandler.showNotification(remoteMessage);
// }




//==============================================
//==main

  //   NotificationHandler.handleFgNotifications(); // Start handling foreground notifications

  //       await FirebaseMessaging.instance.requestPermission();
  // FirebaseMessaging.onBackgroundMessage(bgNotificationHandler);
  //==================================================================
// method
  
  // Future<void> sendNotification(
  //     {required String message, required String receiver}) async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;

  //   if (receiver != auth.currentUser!.uid) {
  //     final user = await _getUserUsingUid(receiver);

  //     String receiverDeviceToken = user.fcmToken!;

  //     // Send a notification to the specific device token
  //     NotificationHandler.showNotification(
  //       RemoteMessage(
  //         notification: RemoteNotification(
  //           title: user.displayName,
  //           body: message,
  //         ),
  //       ),
  //     );
  //   }
  // }
  //=================================================================