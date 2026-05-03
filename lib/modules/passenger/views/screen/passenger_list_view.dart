import 'package:driver_bus_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/shared/custom_app_button.dart';
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
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            backgroundColor: context.cardColor,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        title: Text(
          "Passenger List".tr,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: context.textPrimaryColor),
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
