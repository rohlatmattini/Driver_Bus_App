import 'package:get/get.dart';
import '../../../profile/controllers/profile_controller.dart';
import '../controllers/schedule_controller.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleController>(() => ScheduleController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}