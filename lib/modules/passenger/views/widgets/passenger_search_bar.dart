// import 'package:driver_bus_app/core/constants/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../controllers/passenger_controller.dart';
//
// class PassengerSearchBar extends StatelessWidget {
//   final PassengerController controller;
//   const PassengerSearchBar({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//       child: TextField(
//         cursorColor:AppColor.primaryGreen,
//         onChanged: (val) => controller.searchQuery.value = val,
//         decoration: InputDecoration(
//           hintText: "Search by name or seat...".tr,
//           prefixIcon: const Icon(Icons.search, color: Colors.grey),
//           filled: true,
//
//           fillColor: AppColor.fillColor,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.r),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
// }



// lib/modules/passenger/views/widgets/passenger_search_bar.dart
import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/passenger_controller.dart';

class PassengerSearchBar extends StatelessWidget {
  final PassengerController controller;
  const PassengerSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextField(
        cursorColor: AppColor.primaryGreen,
        onChanged: (val) => controller.searchQuery.value = val,
        style: TextStyle(color: AppColor.black),
        decoration: InputDecoration(
          hintText: "Search by name or seat...".tr,
          hintStyle: TextStyle(color: AppColor.grey),
          prefixIcon: Icon(Icons.search, color: AppColor.grey),
          filled: true,
          fillColor: AppColor.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}