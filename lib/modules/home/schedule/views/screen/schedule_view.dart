// lib/modules/home/schedule/views/screen/schedule_view.dart

import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:driver_bus_app/modules/notifications/views/screen/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/theme_controller.dart';
import '../../../../profile/views/screen/profile_view.dart';
import '../../../../settings/views/screen/settings_view.dart';
import '../../controllers/schedule_controller.dart';
import '../widgets/driver_info_card.dart';
import '../widgets/schedule_bottom_nav_bar.dart';
import '../widgets/schedule_empty_state.dart';
import '../widgets/status_tabs.dart';
import '../widgets/trip_card.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScheduleController controller = Get.find<ScheduleController>();
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      bool isDark = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: AppColor.scaffoldBackground,
        body: _buildBody(controller),
        bottomNavigationBar: ScheduleBottomNavBar(controller: controller),
      );
    });
  }

  Widget _buildBody(ScheduleController controller) {
    switch (controller.currentIndex.value) {
      case 0: return _buildScheduleContent(controller);
      case 1: return const NotificationsView();
      case 2: return const ProfileView();
      case 3: return const SettingsView();
      default: return _buildScheduleContent(controller);
    }
  }

  Widget _buildScheduleContent(ScheduleController controller) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 0),
            child: DriverInfoCard(controller: controller),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: StatusTabs(controller: controller),
          ),
          Expanded(
            child: Obx(() => controller.filteredTrips.isEmpty
                ? const ScheduleEmptyState()
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              itemCount: controller.filteredTrips.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => TripCard(
                trip: controller.filteredTrips[index],
                controller: controller,
              ),
            )),
          ),
        ],
      ),
    );
  }
}