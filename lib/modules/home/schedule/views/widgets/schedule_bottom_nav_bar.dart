import 'package:driver_bus_app/core/extensions/context_extensions.dart';
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
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
        selectedItemColor: AppColor.primaryGreen,
        unselectedItemColor: context.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12.sp,
        unselectedFontSize: 11.sp,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none_rounded,
              size: controller.currentIndex.value == 0 ? 28.sp : 22.sp,
            ),
            label: "Notifications".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment_late_outlined,
              size: controller.currentIndex.value == 1 ? 28.sp : 22.sp,
            ),
            label: "Complaints".tr,
          ),
          // العنصر الفارغ للمنتصف
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.transparent),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              size: controller.currentIndex.value == 3 ? 28.sp : 22.sp,
            ),
            label: "Settings".tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_rounded,
              size: controller.currentIndex.value == 4 ? 28.sp : 22.sp,
            ),
            label: "Profile".tr,
          ),
        ],
      ),
    );
  }
}
