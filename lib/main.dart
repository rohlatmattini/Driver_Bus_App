import 'package:driver_bus_app/routes/app_pages/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'core/constants/app_theme.dart';
import 'core/localization/locale_controller.dart';
import 'core/localization/my_locale.dart';
import 'core/services/api_service.dart';
import 'core/theme/theme_controller.dart';
import 'data/providers/auth_provider.dart';
import 'data/repositories/auth_repository.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  // await GetStorage().write(
  //   'token',
  //   'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N5cmlhLXRyYXZlbC5hcHAvYXBpL2F1dGgvb3RwL2xvZ2luIiwiaWF0IjoxNzc5NTM5NjAzLCJleHAiOjE3OTUwOTE2MDMsIm5iZiI6MTc3OTUzOTYwMywianRpIjoiU3ZSZlU2anJNQW5ieFJsYyIsInN1YiI6IjIwIiwicHJ2IjoiYmI2NWQ5YjhmYmYwZGE5ODI3YzhlZDIzMWQ5YzU0YzgxN2YwZmJiMiJ9.3oDT2UM908qbjF_PU9Cd2-oU7pl4moIKwpMv3MIO-Jc',
  // );
  await Get.putAsync(() => ApiService().init());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final localeController = Get.put(LocaleController());
  final themeController = Get.put(ThemeController());

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(alert: true, badge: true, sound: true);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      Get.snackbar(
        message.notification!.title!,
        message.notification!.body!,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
      );
    }
  });

  String? token = await messaging.getToken();
  print("Firebase Device Token: $token");
  if (token != null) {
    try {
      final authProvider = AuthProvider();
      final authRepository = AuthRepository(authProvider);

      String platform = GetPlatform.isAndroid ? "android" : "ios";

      final response = await authRepository.updateFcmToken(token, platform);

      if (response.statusCode == 200) {
        print("FCM Token Sync Success: ${response.data['message']}");
      }
    } catch (e) {
      print("Error syncing FCM Token to server: $e");
    }
  }

  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

  runApp(
    MyApp(localeController: localeController, themeController: themeController),
  );
}

class MyApp extends StatelessWidget {
  final LocaleController localeController;
  final ThemeController themeController;

  const MyApp({
    super.key,
    required this.localeController,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            title: 'appName'.tr,
            debugShowCheckedModeBanner: false,
            locale: localeController.initialLocale,
            translations: AppTranslations(),
            fallbackLocale: const Locale('en'),
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            themeMode: themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: AppPages.initialRoute,
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}
