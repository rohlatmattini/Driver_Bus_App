import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../home/schedule/controllers/schedule_controller.dart';
import '../../controller/notifications_controller.dart';
import '../widgets/notification_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "notifications".tr,
          style: TextStyle(fontWeight: FontWeight.bold, color: context.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.find<ScheduleController>().changePage(0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done_all, color: context.black),
            onPressed: () => controller.clearAll(),
          ),
        ],
      ),
      body: Obx(
        () => controller.notifications.isEmpty
            ? _buildEmptyState(context)
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) => NotificationCard(
                  notification: controller.notifications[index],
                  onTap: () => controller.markAsRead(index),
                ),
              ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_outlined,
            size: 80.sp,
            color: context.grey.withOpacity(0.4),
          ),
          SizedBox(height: 15.h),
          Text(
            "noNotifications".tr,
            style: TextStyle(color: context.grey, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
