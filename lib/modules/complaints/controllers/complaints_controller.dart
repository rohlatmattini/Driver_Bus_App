// lib/modules/complaints/controllers/complaints_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        Get.snackbar(
          "success".tr,
          "complaintSentSuccess".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
        );
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
