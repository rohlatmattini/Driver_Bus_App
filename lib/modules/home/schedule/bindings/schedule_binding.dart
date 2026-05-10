import 'package:get/get.dart';

import '../../../../data/providers/profile_provider.dart';
import '../../../../data/repositories/profile_repository.dart';
import '../../../profile/controllers/profile_controller.dart';
import '../controllers/schedule_controller.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleController>(() => ScheduleController());

    Get.lazyPut<ProfileProvider>(() => ProfileProvider());
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepository(Get.find<ProfileProvider>()),
    );

    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find<ProfileRepository>()),
    );
  }
}
