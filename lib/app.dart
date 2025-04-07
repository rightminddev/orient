import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:orient/general_services/alert_service/alerts.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'constants/app_images.dart';
import 'general_services/app_theme.service.dart';
import 'package:orient/routing/app_router.dart';
import 'platform/platform_is.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class MyApp extends StatelessWidget {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void _setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission for notifications
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ User granted permission");
    } else {
      print("❌ User denied permission");
    }

    // Get FCM Token
    String? token = await messaging.getToken();
    print("🔑 FCM Token: $token");

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("🔔 Foreground Notification: ${message.notification?.title}");
      _showNotification(message);
    });

    // Handle notification click when app is open
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📩 User clicked notification: ${message.notification?.title}");
    });

    // Initialize local notifications
    _initializeLocalNotifications();
  }

  void _initializeLocalNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iOSSettings = DarwinInitializationSettings();
    const InitializationSettings settings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("🔔 Local Notification Clicked");
      },
    );
  }

  void _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id', 'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      icon: '@drawable/notif_icon',
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();
    const NotificationDetails generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? "No Title",
      message.notification?.body ?? "No Body",
      generalNotificationDetails,
    );
  }
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _setupFirebaseMessaging();
    DioHelper.initail(context);
    if(CacheHelper.getString("lang") == ""){
      print("=========0");
      CacheHelper.setString(key: "lang", value: context.locale.languageCode);
      print("lang is ${CacheHelper.getString("lang")}");
    }
    print("langs is ${CacheHelper.getString("lang")}");
    // precache spash screen image
    precacheImage(const AssetImage(AppImages.splashScreenBackground), context);

    final appGoRouter = goRouter(context);
    return
    MaterialApp.router(
      title: 'Orient',
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      routerDelegate: appGoRouter.routerDelegate,
      routeInformationParser: appGoRouter.routeInformationParser,
      routeInformationProvider: appGoRouter.routeInformationProvider,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      scaffoldMessengerKey: AlertsService.scaffoldMessengerKey,
      locale: context.locale,
      themeMode: ThemeMode.light,
      theme: AppThemeService.getTheme(isDark: false, context: context),
      darkTheme: AppThemeService.getTheme(isDark: true, context: context),
      scrollBehavior: PlatformIs.web ? AppScrollBehavior() : null,
    );

  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.trackpad,
      };
}
