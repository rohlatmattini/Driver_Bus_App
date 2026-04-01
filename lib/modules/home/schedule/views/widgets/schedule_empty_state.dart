// lib/modules/home/schedule/views/widgets/schedule_empty_state.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/constants/app_color.dart';

class ScheduleEmptyState extends StatelessWidget {
  const ScheduleEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              Icons.directions_bus_filled_outlined,
              size: 70.sp,
              color: AppColor.grey.withOpacity(0.3)
          ),
          SizedBox(height: 15.h),
          Text(
              'noTrips'.tr,
              style: TextStyle(
                  color: AppColor.grey,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
              )
          ),
        ],
      ),
    );
  }
}