import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/schedule_controller.dart';

class DriverInfoCard extends StatelessWidget {
  final ScheduleController controller;
  const DriverInfoCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back,".tr,
                  style: TextStyle(
                    color: context.textTertiaryColor,
                    fontSize: 14.sp,
                  ),
                ),
                Obx(
                  () => Text(
                    "Captain ".tr + controller.driver.value.name,
                    style: TextStyle(
                      color: context.textPrimaryColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColor.primaryGreen,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.driver.value.isOnline
                        ? AppColor.green
                        : AppColor.error,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Active Status: ".tr +
                        (controller.driver.value.isOnline
                            ? "Online".tr
                            : "Offline".tr),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: controller.toggleDriverStatus,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      controller.driver.value.isOnline
                          ? "Go Offline".tr
                          : "Go Online".tr,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
