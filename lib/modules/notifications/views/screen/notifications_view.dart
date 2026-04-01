// lib/modules/notifications/views/screen/notifications_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_color.dart';
import '../../../home/schedule/controllers/schedule_controller.dart';
import '../../controller/notifications_controller.dart';
import '../widgets/notification_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        title: Text("notifications".tr,
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:
        IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () =>
                Get.find<ScheduleController>().changePage(0)

        ),
        actions: [
          IconButton(
            icon:  Icon(Icons.done_all, color: AppColor.black),
            onPressed: () => controller.clearAll(),
          ),

        ],
      ),
      body: Obx(() => controller.notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        itemCount: controller.notifications.length,
        itemBuilder: (context, index) => NotificationCard(
          notification: controller.notifications[index],
          onTap: () => controller.markAsRead(index),
        ),
      )),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_outlined, size: 80.sp, color: AppColor.grey.withOpacity(0.4)),
          SizedBox(height: 15.h),
          Text("noNotifications".tr, style: TextStyle(color: AppColor.grey, fontSize: 16.sp)),
        ],
      ),
    );
  }
}