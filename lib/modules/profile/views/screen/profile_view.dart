import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../home/schedule/controllers/schedule_controller.dart';
import '../../controllers/profile_controller.dart';
import '../widgets/detail_info_tile.dart';
import '../widgets/info_grid_cards.dart';
import '../widgets/profile_avatar.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController =
        Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.find<ScheduleController>().changePage(0),
        ),
        title: Text(
          "Driver Profile".tr,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const ProfileAvatar(),
            SizedBox(height: 16.h),
            Obx(
              () => Text(
                controller.name.value,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: AppColor.primaryGreen, size: 16.sp),
                  Text(
                    " ${controller.rating.value} ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryGreen,
                    ),
                  ),
                  Text(
                    "(${controller.totalTrips.value} ${'trips'.tr})",
                    style: TextStyle(
                      color: context.textTertiaryColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Obx(
                  () => InfoGridCards(
                    title: "Experience".tr,
                    value: controller.experience.value,
                  ),
                ),
                SizedBox(width: 12.w),
                Obx(
                  () => InfoGridCards(
                    title: "Status".tr,
                    value: controller.status.value,
                    isStatus: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Obx(
              () => DetailInfoTile(
                title: "License Number".tr,
                value: controller.licenseNumber.value,
                icon: Icons.badge_outlined,
              ),
            ),
            Obx(
              () => DetailInfoTile(
                title: "Assigned Vehicle".tr,
                value: controller.vehicle.value,
                icon: Icons.directions_bus_outlined,
                hasArrow: true,
              ),
            ),
            Obx(
              () => DetailInfoTile(
                title: "Email Address".tr,
                value: controller.email.value,
                icon: Icons.mail_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
