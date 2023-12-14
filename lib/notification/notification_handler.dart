import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FirebasePushNotificationsHandler {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  AndroidNotificationChannel? channel;
  FirebaseMessaging? _messaging = FirebaseMessaging.instance;
  static Map<dynamic, dynamic>? _messageMain;
  Future registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage((firebaseMessagingBackgroundHandler) {
      return _navigateToScreen(firebaseMessagingBackgroundHandler.data);
    });

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        // 'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel!);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      init();
    }

  }

  void init() {

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      print('message:::${message}');

      if (message != null) {
        print('navigate : $message');
        Future.delayed(Duration(milliseconds: 3500),() async {
          Get.context!.loaderOverlay.hide();
          await _navigateToScreen(message.data);
        });
      }
    });
    checkForInitialMessage();
    _initializeLocalNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print('message11:::${message.data}');
      log('message12:::${message.notification}');
      _messageMain = message.data;

      if (notification != null && android != null && !kIsWeb) {

        flutterLocalNotificationsPlugin?.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel?.id ?? '',
              channel?.name ?? '',
              priority: Priority.max,
              importance: Importance.max,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
        // WriteAboutCarPageState().initState();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('navigate1 : $message');
      _navigateToScreen(message.data);
      print('A new onMessageOpenedApp event was published!');
    });
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print('navigate2 : ${initialMessage.data}');
      Future.delayed(Duration(milliseconds: 3500),() async {
        Get.context!.loaderOverlay.hide();

        _navigateToScreen(initialMessage.data);
      });
    }
  }

  static _navigateToScreen(Map<dynamic, dynamic>? message) async {
    print('navigate3 : $message');
    if (message != null) {
      print('msg : $message');
      Map<dynamic, dynamic> data;
      if (Platform.isAndroid) {
        data = message;
        print('Notification ::::: $data');
      } else {
        data = message;
      }
      Get.toNamed("/ChatDetails", arguments: [
        data['peerId'],
        '',
        data['peerNickname'],
      ]
      );
      // Get.offUntil(page, (route) => false);
      /*if(data['message'] == null){
       // navigate screen
      }*/

    }
  }

  ///configure local notification
  _initializeLocalNotification() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
     AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin?.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotification,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification);

/*    await flutterLocalNotificationsPlugin?.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: onSelectNotification,
    );*/

  }

  Future<void> onDidReceiveLocalNotification(
      int? id, String? title, String? body, dynamic payload) async {
    // print("onDid $_messageMain");
    print("payload $payload");

    if (payload != null) {
      if (Platform.isAndroid) {
        _navigateToScreen(payload);
      } else {
        _navigateToScreen(payload);
      }
    }
  }

  Future<void> onSelectNotification(dynamic payload) async {
    if (Platform.isAndroid) {
      print("on select : before");
      // String ss = await _getMainMsg();
      print("payload ::::: $payload");
      _navigateToScreen(_messageMain);
    } else {
      _navigateToScreen(_messageMain);
    }
  }

}