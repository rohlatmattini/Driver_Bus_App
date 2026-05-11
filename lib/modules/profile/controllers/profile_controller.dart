import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/services/api_service.dart';
import '../../../core/shared/custom_snackbar.dart';
import '../../../data/models/driver_model.dart';
import '../../../data/repositories/profile_repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repository;

  ProfileController(this._repository);

  var isLoading = true.obs;
  var isUpdating = false.obs;
  var driverData = Rxn<DriverModel>();

  var profileImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  // Controllers for Editing
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final response = await _repository.getDriverProfile();
      if (response.statusCode == 200) {
        driverData.value = DriverModel.fromJson(response.data['data']);
        _fillControllers();
      }
    } catch (e) {
      CustomSnackBar.showError('profile_load_error'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  void _fillControllers() {
    nameController.text = driverData.value?.name ?? "";
    phoneController.text = driverData.value?.phone ?? "";
    emailController.text = driverData.value?.email ?? "";
  }

  Future<void> updateProfile() async {
    try {
      isUpdating.value = true;
      final response = await _repository.updateDriverProfile(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        imagePath: profileImagePath.value,
      );

      if (response.statusCode == 200) {
        Get.back();
        fetchProfile();
        profileImagePath.value = '';
        CustomSnackBar.showSuccess('profile_update_success'.tr);
      }
    } catch (e) {
      CustomSnackBar.showError('profile_update_error'.tr);
    } finally {
      isUpdating.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        profileImagePath.value = pickedFile.path;
        await uploadJustImage();
      }
    } catch (e) {
      CustomSnackBar.showError('image_pick_error'.tr);
    }
  }

  Future<void> uploadJustImage() async {
    try {
      isUpdating.value = true;
      final response = await _repository.updateDriverProfile(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        imagePath: profileImagePath.value,
      );

      if (response.statusCode == 200) {
        fetchProfile();
        profileImagePath.value = '';
        CustomSnackBar.showSuccess('image_update_success'.tr);
      }
    } catch (e) {
      CustomSnackBar.showError('image_upload_error'.tr);
    } finally {
      isUpdating.value = false;
    }
  }

  void logout() {
    Get.find<ApiService>().logout(isAutomatic: false);
  }

  void back() {
    Get.back();
  }
}
