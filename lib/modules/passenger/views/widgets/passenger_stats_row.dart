// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../../core/constants/app_color.dart';
//
// class PassengerStatsRow extends StatelessWidget {
//   const PassengerStatsRow({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//       child: Row(
//         children: [
//           _buildStatItem("TOTAL".tr, "42/50", AppColor.black),
//           SizedBox(width: 10.w),
//           _buildStatItem("PAID".tr, "38", AppColor.success),
//           SizedBox(width: 10.w),
//           _buildStatItem("UNPAID".tr, "4", AppColor.error),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatItem(String label, String value, Color color) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(12.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(label, style: TextStyle(fontSize: 9.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
//             Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: color)),
//           ],
//         ),
//       ),
//     );
//   }
// }


// lib/modules/passenger/views/widgets/passenger_stats_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_color.dart';

class PassengerStatsRow extends StatelessWidget {
  const PassengerStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          _buildStatItem("TOTAL".tr, "42/50", AppColor.black),
          SizedBox(width: 10.w),
          _buildStatItem("PAID".tr, "38", AppColor.success),
          SizedBox(width: 10.w),
          _buildStatItem("UNPAID".tr, "4", AppColor.error),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(color: AppColor.black.withOpacity(0.02), blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 9.sp, color: AppColor.grey, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}