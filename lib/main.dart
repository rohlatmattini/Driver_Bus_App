// lib/main.dart
import 'package:driver_bus_app/modules/passenger/views/screen/passenger_list_view.dart';
import 'package:driver_bus_app/routes/app_pages/app_pages.dart';
import 'package:driver_bus_app/routes/app_routes/app_routes.dart';
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
import 'core/theme/theme_controller.dart';
import 'firebase_options.dart';
import 'modules/auth/login/bindings/login_binding.dart';
import 'modules/auth/login/views/screen/LoginView.dart';
import 'modules/home/schedule/views/screen/schedule_view.dart';
import 'modules/profile/views/screen/profile_view.dart';
import 'modules/trip_details/views/screen/trip_details_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final localeController = Get.put(LocaleController());
  final themeController = Get.put(ThemeController());

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

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


  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

  runApp(MyApp(localeController: localeController, themeController: themeController));
}
class MyApp extends StatelessWidget {
  final LocaleController localeController;
  final ThemeController themeController;

  const MyApp({super.key, required this.localeController, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(() => GetMaterialApp(
          title: 'appName'.tr,
          debugShowCheckedModeBanner: false,
          locale: localeController.initialLocale,
          translations: AppTranslations(),
          fallbackLocale: const Locale('en'),
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: themeController.theme,
          initialRoute: AppRoutes.schedule,
          getPages: AppPages.routes,
        ));
      },
    );
  }
}