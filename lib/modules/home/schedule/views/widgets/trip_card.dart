// lib/modules/home/schedule/views/widgets/trip_card.dart
import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../data/models/trip_model.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../controllers/schedule_controller.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  final ScheduleController controller;

  const TripCard({super.key, required this.trip, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.tripDetails, arguments: trip);
        },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [BoxShadow(color: AppColor.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
          border: Border.all(color: AppColor.grey.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: trip.status == 'ongoing' ? AppColor.green.withOpacity(0.1) : AppColor.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(trip.status.toUpperCase().tr,
                      style: TextStyle(color: trip.status == 'ongoing' ? AppColor.green : AppColor.blue, fontSize: 10.sp, fontWeight: FontWeight.bold)),
                ),
                Text("ID: #${trip.id}", style: TextStyle(color: AppColor.grey, fontSize: 12.sp)),
              ],
            ),
            SizedBox(height: 20.h),
            _buildLocationRow(Icons.radio_button_off, "ORIGIN".tr, trip.pickupLocation, isFirst: true),
            _buildLocationRow(Icons.circle, "DESTINATION".tr, trip.destination, isLast: true),
            SizedBox(height: 12.h),
            Divider(color: AppColor.grey.withOpacity(0.2)),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time_filled, size: 16.sp, color: AppColor.grey),
                    SizedBox(width: 6.w),
                    Text(trip.time, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColor.black)),
                  ],
                ),
                if (trip.hasMap)
                  ElevatedButton(
                    onPressed: () => controller.viewMap(trip),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: Text("View Map".tr, style: TextStyle(fontSize: 12.sp)),
                  )
                else if (trip.busNumber != null)
                  Text("Bus #${trip.busNumber}", style: TextStyle(color: AppColor.grey, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, String label, String city, {bool isFirst = false, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, size: 16.sp, color: AppColor.black),
            if (!isLast) Container(width: 1.5, height: 35.h, color: AppColor.grey.withOpacity(0.3)),
          ],
        ),
        SizedBox(width: 14.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: AppColor.grey, fontSize: 10.sp, letterSpacing: 1)),
            Text(city, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.black)),
            if (!isLast) SizedBox(height: 15.h),
          ],
        )
      ],
    );
  }
}