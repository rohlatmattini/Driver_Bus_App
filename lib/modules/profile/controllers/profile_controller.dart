import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = "Ahmed Hassan".obs;
  var rating = 4.9.obs;
  var totalTrips = 1240.obs;
  var experience = "8 Years".obs;
  var status = "Active".obs;
  var licenseNumber = "DL-4482-9910-X".obs;
  var vehicle = "Volvo 9600 - AC (B-402)".obs;
  var email = "ahmed.hassan@busapp.com".obs;

  void back() {
    Get.back();
  }
}