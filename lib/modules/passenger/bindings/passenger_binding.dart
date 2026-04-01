// lib/modules/passenger/bindings/passenger_binding.dart
import 'package:get/get.dart';
import '../controllers/passenger_controller.dart';

class PassengerBinding extends Bindings {
  @override
  void dependencies() {
    // الـ Controller بصير جاهز أول ما تفتح الصفحة وبنحذف من الذاكرة بس تتسكر
    Get.lazyPut<PassengerController>(() => PassengerController());
  }
}