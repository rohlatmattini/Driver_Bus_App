import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/login_model.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../core/localization/locale_controller.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final LocaleController _localeController = Get.find<LocaleController>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final loginModel = LoginModel(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );

    final response = await _authRepository.login(loginModel);

    isLoading.value = false;

    if (response.success) {
      Get.snackbar(
        'success'.tr,
        'loginSuccess'.tr,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Navigate to home page
      // Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar(
        'error'.tr,
        response.message ?? 'loginFailed'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void changeLanguage(String langCode) {
    _localeController.changeLocale(langCode);
  }
}