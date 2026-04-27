// import 'package:driver_bus_app/core/constants/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../controllers/passenger_controller.dart';
// import '../widgets/passenger_card.dart';
// import '../widgets/passenger_search_bar.dart';
// import '../widgets/passenger_stats_row.dart';
// import '../widgets/route_info_card.dart';
//
// class PassengerListView extends StatelessWidget {
//   const PassengerListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(PassengerController());
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         backgroundColor: AppColor.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color:AppColor.black),
//           onPressed: () => Get.back(),
//         ),
//         title:  Text("Passenger List".tr, style: TextStyle(color: AppColor.black, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         actions: [IconButton(icon: Icon(Icons.more_horiz, color: AppColor.black), onPressed: () {})],
//       ),
//       body: Column(
//         children: [
//           const RouteInfoCard(),
//           PassengerSearchBar(controller: controller),
//           const PassengerStatsRow(),
//           Expanded(
//             child: Obx(() => ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               itemCount: controller.filteredPassengers.length,
//               itemBuilder: (context, index) => PassengerCard(
//                 passenger: controller.filteredPassengers[index],
//               ),
//             )),
//           ),
//           _buildScanButton(),
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget _buildScanButton() {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       child: ElevatedButton.icon(
//         onPressed: () {},
//         icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
//         label:  Text("Scan Ticket".tr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColor.primaryGreen,
//           minimumSize: Size(double.infinity, 55.h),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
//         ),
//       ),
//     );
//   }

// }

// lib/modules/passenger/views/screen/passenger_list_view.dart
import 'package:driver_bus_app/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/shared/custom_button.dart';
import '../../../../routes/app_routes/app_routes.dart';
import '../../controllers/passenger_controller.dart';
import '../widgets/passenger_card.dart';
import '../widgets/passenger_search_bar.dart';
import '../widgets/passenger_stats_row.dart';
import '../widgets/route_info_card.dart';

class PassengerListView extends StatelessWidget {
  const PassengerListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PassengerController());

    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Passenger List".tr,
          style: TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: AppColor.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const RouteInfoCard(),
          PassengerSearchBar(controller: controller),
          const PassengerStatsRow(),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: controller.filteredPassengers.length,
                itemBuilder: (context, index) => PassengerCard(
                  passenger: controller.filteredPassengers[index],
                ),
              ),
            ),
          ),
          _buildScanButton(),
        ],
      ),
    );
  }

  Widget _buildScanButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: CustomAppButton(
        text: "Scan Ticket".tr,
        icon: Icons.qr_code_scanner,
        onPressed: () => Get.toNamed(AppRoutes.qrScanner),
      ),
    );
  }
}
