// lib/modules/trip_details/views/widgets/trip_info_stat_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_color.dart';

class TripInfoStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const TripInfoStatCard({super.key, required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [BoxShadow(color: AppColor.black.withOpacity(0.02), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AppColor.grey, fontSize: 12.sp)),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(icon, size: 20.sp, color: AppColor.primaryGreen),
              SizedBox(width: 8.w),
              Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.black)),
            ],
          ),
        ],
      ),
    );
  }
}