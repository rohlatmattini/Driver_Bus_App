// lib/modules/passenger/views/widgets/passenger_stats_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../controllers/passenger_controller.dart';

class PassengerStatsRow extends StatelessWidget {
  const PassengerStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final PassengerController controller = Get.find();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Obx(
        () => Row(
          children: [
            _buildStatItem(
              "TOTAL".tr,
              "${controller.passengers.length}/50",
              AppColor.black,
              isActive: controller.selectedFilter.value == 'ALL',
              onTap: () => controller.setFilter('ALL'),
            ),
            SizedBox(width: 10.w),
            _buildStatItem(
              "PAID".tr,
              "${controller.passengers.where((p) => p.isPaid).length}",
              AppColor.success,
              isActive: controller.selectedFilter.value == 'PAID',
              onTap: () => controller.setFilter('PAID'),
            ),
            SizedBox(width: 10.w),
            _buildStatItem(
              "UNPAID".tr,
              "${controller.passengers.where((p) => !p.isPaid).length}",
              AppColor.error,
              isActive: controller.selectedFilter.value == 'UNPAID',
              onTap: () => controller.setFilter('UNPAID'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    Color color, {
    required VoidCallback onTap,
    required bool isActive,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isActive ? color.withOpacity(0.5) : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(color: AppColor.black.withOpacity(0.02), blurRadius: 5),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 9.sp,
                  color: AppColor.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
