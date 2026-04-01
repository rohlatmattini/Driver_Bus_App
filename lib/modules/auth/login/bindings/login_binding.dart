import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../../data/providers/auth_provider.dart';
import '../../../../data/repositories/auth_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // تسجيل AuthProvider أولاً
    Get.lazyPut<AuthProvider>(() => AuthProvider());

    // تسجيل AuthRepository مع حقن AuthProvider
    Get.lazyPut<AuthRepository>(() => AuthRepository());

    // تسجيل LoginController
    Get.lazyPut<LoginController>(() => LoginController());
  }
}