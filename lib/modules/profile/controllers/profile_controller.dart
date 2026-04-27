import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var name = "Ahmed Hassan".obs;
  var rating = 4.9.obs;
  var totalTrips = 1240.obs;
  var experience = "8 Years".obs;
  var status = "Active".obs;
  var licenseNumber = "DL-4482-9910-X".obs;
  var vehicle = "Volvo 9600 - AC (B-402)".obs;
  var email = "ahmed.hassan@busapp.com".obs;

  var profileImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        profileImagePath.value = pickedFile.path;
      }
    } catch (e) {
      Get.snackbar('Error'.tr, 'Failed to pick image'.tr);
    }
  }
}

void back() {
  Get.back();
}
