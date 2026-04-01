import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../data/models/passenger_model.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import '../views/widgets/ticket_details_dialog.dart';

class PassengerController extends GetxController {
  var passengers = <PassengerModel>[].obs;
  var searchQuery = ''.obs;
  var scannedTicketData = {}.obs;
  var currentScannedPassenger = Rxn<PassengerModel>();
  @override
  void onInit() {
    super.onInit();
    loadPassengers();
  }
  void processQrCode(String? code) {
    if (code == null) return;

    try {
      // 1. تحويل النص القادم من الـ QR إلى Map
      Map<String, dynamic> data = jsonDecode(code);

      // 2. تحويل الـ Map إلى Model
      currentScannedPassenger.value = PassengerModel.fromJson(data);

      // 3. إغلاق الكاميرا وفتح النتيجة
      Get.back();
      showTicketResult();
    } catch (e) {
      Get.snackbar("Error", "Invalid Ticket Format",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void showTicketResult() {
    if (currentScannedPassenger.value == null) return;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: const TicketDetailsDialog(),
      ),
    );
  }

  void loadPassengers() {
    passengers.value = [
      PassengerModel(id: '#B8394-01', name: 'Ahmed Mansour', seatNumber: '01', isPaid: true),
      PassengerModel(id: '#B8394-02', name: 'Sarah Wilson', seatNumber: '02', isPaid: false),
      PassengerModel(id: '#B8394-03', name: 'Michael Chen', seatNumber: '03', isPaid: true),
      PassengerModel(id: '#B8394-04', name: 'Layla Ibrahim', seatNumber: '04', isPaid: true),
    ];
  }

  List<PassengerModel> get filteredPassengers => passengers
      .where((p) => p.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
      .toList();


  void openTicketScanner() {

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        child: const TicketDetailsDialog(),
      ),
      barrierDismissible: true,
    );
  }
}