// lib/modules/trip_details/views/screen/trip_details_view.dart

import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:driver_bus_app/routes/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/shared/custom_button.dart';
import '../../controllers/trip_details_controller.dart';
import '../widgets/status_dropdown_selector.dart';
import '../widgets/trip_map_preview.dart';
import '../widgets/trip_info_stat_card.dart';
import '../widgets/trip_section_title.dart';

class TripDetailsView extends StatelessWidget {
  const TripDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TripDetailsController());

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            backgroundColor: AppColor.cardColor,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black,
              ),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        title: Text(
          "tripDetails".tr,
          style: TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TripMapPreview(),
            SizedBox(height: 24.h),

            // معلومات الرحلة الأساسية
            Obx(
              () => Text(
                "${"route".tr} ${controller.routeId.value}",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
            ),

            SizedBox(height: 8.h),

            Obx(
              () => Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColor.primaryGreen,
                    size: 18.sp,
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      "${controller.pickupLocation.value} ➔ ${controller.destination.value}",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Obx(
              () => Text(
                "${"scheduledDeparture".tr}: ${controller.departureTime.value}",
                style: TextStyle(color: AppColor.grey, fontSize: 14.sp),
              ),
            ),

            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.passengerList),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Obx(
                      () => TripInfoStatCard(
                        label: "passengers".tr,
                        value: "${controller.passengerCount.value}",
                        icon: Icons.people_outline,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Obx(
                    () => TripInfoStatCard(
                      label: "distance".tr,
                      value: controller.distance.value,
                      icon: Icons.map_outlined,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            // --- استخدام الودجت الجديدة ---
            TripSectionTitle(title: "tripStatus".tr),
            StatusDropdownSelector(
              value: controller.tripStatus,
              options: controller.tripStatusOptions,
              icon: Icons.directions_bus_filled_rounded,
              onChanged: (val) => controller.updateTripStatus(val),
            ),

            SizedBox(height: 20.h),

            TripSectionTitle(title: "busStatus".tr),
            StatusDropdownSelector(
              value: controller.busStatus,
              options: controller.busStatusOptions,
              icon: Icons.settings_suggest_rounded,
              onChanged: (val) => controller.updateBusStatus(val),
            ),

            SizedBox(height: 40.h),

            // استخدام الزر العام الموحد
            CustomAppButton(
              text: "startTrip".tr,
              onPressed: () => controller.startTripAction(),
            ),
          ],
        ),
      ),
    );
  }
}
