import 'package:get/get.dart';
import '../../../../data/models/trip_model.dart';

class TripDetailsController extends GetxController {
  // بيانات الرحلة الأساسية
  var routeId = "".obs;
  var pickupLocation = "".obs;
  var destination = "".obs;
  var departureTime = "".obs;
  var passengerCount = "40/50".obs;
  var distance = "150 km".obs;

  // FR2.3.3: حالة الرحلة (بدأت - وصلت)
  var tripStatus = "Start".obs;
  final List<String> tripStatusOptions = ['Start', 'Arrived'];

  // FR2.3.4: حالة الباص (جاهز - يحتاج صيانة - عطل - طارئ)
  var busStatus = "Ready".obs;
  final List<String> busStatusOptions = ['Ready', 'Needs Maintenance', 'Breakdown', 'Emergency'];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      TripModel trip = Get.arguments as TripModel;
      routeId.value = "#TR-${trip.id}";
      pickupLocation.value = trip.pickupLocation;
      destination.value = trip.destination;
      departureTime.value = trip.time;
      // يمكنك تهيئة الحالات من الموديل إذا كانت قادمة من السيرفر
    }
  }

  // تغيير حالة الرحلة
  void updateTripStatus(String? newValue) {
    if (newValue != null) tripStatus.value = newValue;
  }

  // تغيير حالة الباص
  void updateBusStatus(String? newValue) {
    if (newValue != null) busStatus.value = newValue;
  }

  void startTripAction() {
    Get.snackbar("Action".tr, "${"Current Status".tr}: ${tripStatus.value}");
  }
}