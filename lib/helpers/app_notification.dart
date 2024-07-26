import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';

import '../main.dart';
import 'router/app_name_route.dart';

class MyNotification {
  static Future<void> initialise() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) {},
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var notification = message.notification!;
      showNotification(
        notification.title!,
        notification.body!,
        flutterLocalNotificationsPlugin,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      var context = MyApp.navigatorKey.currentState!.context;
      AppNameRoute.allCoursesScreen.go(context);
    });
  }

  static getInitialMessage() async {
    await FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        var context = MyApp.navigatorKey.currentState!.context;
        AppNameRoute.allCoursesScreen.go(context);
      }
    });
  }

  static showNotification(
    String title,
    String body,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    Random random = Random();
    int id = random.nextInt(10000);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "id_101",
      "channel_101",
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
    );
    const iosNotificationDetail = DarwinNotificationDetails(
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosNotificationDetail,
    );
    await fln.show(id, title, body, platformChannelSpecifics);
  }

  static Future<dynamic> onBackgroundMessage(
    RemoteMessage message,
  ) async {
    if (kDebugMode) {
      print('onBackgroundMessage ${message.notification!.body}');
    }
  }
}
