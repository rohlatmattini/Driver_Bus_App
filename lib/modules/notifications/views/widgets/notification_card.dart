import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/constants/app_color.dart';
import '../../../../data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.isDarkMode;

    String timeStr = timeago.format(
      notification.timestamp,
      locale: Get.locale?.languageCode == 'ar' ? 'ar' : 'en_short',
    );

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: notification.isRead
              ? (isDark ? context.cardColor.withOpacity(0.5) : context.white)
              : (AppColor.primaryGreen.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: notification.isRead
                ? Colors.transparent
                : AppColor.primaryGreen.withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIcon(),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        timeStr,
                        style: TextStyle(color: context.grey, fontSize: 11.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.grey,
                      fontSize: 13.sp,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    Color iconColor;

    switch (notification.type) {
      case NotificationType.trip:
        iconData = Icons.directions_bus_filled;
        iconColor = AppColor.primaryGreen;
        break;
      case NotificationType.alert:
        iconData = Icons.warning_rounded;
        iconColor = AppColor.orange;
        break;
      case NotificationType.message:
        iconData = Icons.mark_as_unread_sharp;
        iconColor = AppColor.blue;
        break;
    }

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: iconColor, size: 22.sp),
    );
  }
}
