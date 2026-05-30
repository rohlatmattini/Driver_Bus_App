import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 🔥 استيراد السناك بار المخصص الخاص بك
import '../../../core/shared/custom_snackbar.dart';

class ComplaintsController extends GetxController {
  final complaintController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  void sendComplaint() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        await Future.delayed(const Duration(seconds: 2));

        Get.back();

        CustomSnackBar.showSuccess("complaintSentSuccess");
      } catch (e) {
        CustomSnackBar.showError("Failed to send complaint");
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    complaintController.dispose();
    super.onClose();
  }
}
