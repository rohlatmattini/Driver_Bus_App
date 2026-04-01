// lib/modules/home/schedule/views/widgets/schedule_bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/constants/app_color.dart';
import '../../controllers/schedule_controller.dart';

class ScheduleBottomNavBar extends StatelessWidget {
  final ScheduleController controller;

  const ScheduleBottomNavBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
              color: AppColor.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, -5)
          ),
        ],
        border: Border(top: BorderSide(color: AppColor.grey.withOpacity(0.2), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.directions_bus_rounded, "Trips".tr, 0),
          _buildNavItem(Icons.messenger_outline_outlined, "Notifications".tr, 1),
          _buildNavItem(Icons.person_outline_rounded, "Profile".tr, 2),
          _buildNavItem(Icons.settings_outlined, "settings".tr, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return Obx(() {
      bool isSelected = controller.currentIndex.value == index;
      return InkWell(
        onTap: () => controller.changePage(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                icon,
                color: isSelected ? AppColor.primaryGreen : AppColor.grey,
                size: 26.sp
            ),
            SizedBox(height: 5.h),
            Text(
                label,
                style: TextStyle(
                    color: isSelected ? AppColor.primaryGreen : AppColor.grey,
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500
                )
            ),
          ],
        ),
      );
    });
  }
}