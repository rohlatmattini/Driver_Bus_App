import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:driver_bus_app/modules/notifications/views/screen/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../complaints/controllers/complaints_controller.dart';
import '../../../../complaints/views/screen/complaints_view.dart';
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

    Get.lazyPut(() => ComplaintsController());

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [
            const NotificationsView(),
            const ComplaintsView(),
            _buildScheduleContent(controller),
            const SettingsView(),
            const ProfileView(),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 35.h),
        height: 60.r,
        width: 60.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: context.white,
          shape: CircleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          ),
          onPressed: () => controller.changePage(2),
          child: Icon(
            Icons.directions_bus_rounded,
            color: AppColor.primaryGreen,
            size: 28.r,
          ),
        ),
      ),
      bottomNavigationBar: ScheduleBottomNavBar(controller: controller),
    );
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
            child: Obx(
              () => controller.filteredTrips.isEmpty
                  ? const ScheduleEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      itemCount: controller.filteredTrips.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => TripCard(
                        trip: controller.filteredTrips[index],
                        controller: controller,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
