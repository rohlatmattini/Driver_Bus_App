// lib/core/routes/app_pages.dart

import 'package:driver_bus_app/modules/auth/forget_password/binding/forget_password_binding.dart';
import 'package:driver_bus_app/modules/auth/forget_password/views/screen/forgot_password_view.dart';
import 'package:driver_bus_app/modules/auth/forget_password/views/screen/reset_password_screen.dart';
import 'package:driver_bus_app/modules/home/schedule/views/screen/schedule_view.dart';
import 'package:driver_bus_app/modules/notifications/views/screen/notifications_view.dart';
import 'package:driver_bus_app/modules/profile/views/screen/profile_view.dart';
import 'package:driver_bus_app/modules/trip_details/views/screen/trip_details_view.dart';
import 'package:get/get.dart';
import '../../modules/complaints/bindings/complaints_binding.dart';
import '../../modules/complaints/views/screen/complaints_view.dart';
import '../../modules/home/schedule/bindings/schedule_binding.dart';
import '../../modules/passenger/bindings/passenger_binding.dart';
import '../app_routes/app_routes.dart';
import '../../modules/auth/login/views/screen/LoginView.dart';
import '../../modules/auth/login/bindings/login_binding.dart';
import '../../modules/passenger/views/screen/passenger_list_view.dart';
import '../../modules/passenger/views/screen/qr_scanner_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.passengerList,
      page: () => const PassengerListView(),
      binding: PassengerBinding(),
    ),
    GetPage(
      name: AppRoutes.qrScanner,
      page: () => const QrScannerView(),
      transition: Transition.cupertino,
      binding: PassengerBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: AppRoutes.schedule,
      page: () => const ScheduleView(),
      transition: Transition.cupertino,
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: AppRoutes.tripDetails,
      page: () => const TripDetailsView(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: AppRoutes.complaints,
      page: () => const ComplaintsView(),
      binding: ComplaintsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => const ForgotPasswordView(),
      transition: Transition.cupertino,
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
      transition: Transition.cupertino,
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      transition: Transition.cupertino,
    ),

  ];
}