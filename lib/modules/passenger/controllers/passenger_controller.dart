import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/models/passenger_model.dart';
import '../views/widgets/ticket_details_dialog.dart';

class PassengerController extends GetxController {
  var passengers = <PassengerModel>[].obs;
  var searchQuery = ''.obs;
  var scannedTicketData = {}.obs;
  var currentScannedPassenger = Rxn<PassengerModel>();
  var selectedFilter = 'ALL'.obs;
  @override
  void onInit() {
    super.onInit();
    loadPassengers();
  }

  void processQrCode(String? code) {
    if (code == null) return;

    try {
      Map<String, dynamic> data = jsonDecode(code);

      currentScannedPassenger.value = PassengerModel.fromJson(data);

      Get.back();
      showTicketResult();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Invalid Ticket Format",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
      PassengerModel(
        id: '#B8394-01',
        name: 'Ahmed Mansour',
        seatNumber: '01',
        isPaid: true,
      ),
      PassengerModel(
        id: '#B8394-02',
        name: 'Sarah Wilson',
        seatNumber: '02',
        isPaid: false,
      ),
      PassengerModel(
        id: '#B8394-03',
        name: 'Michael Chen',
        seatNumber: '03',
        isPaid: true,
      ),
      PassengerModel(
        id: '#B8394-04',
        name: 'Layla Ibrahim',
        seatNumber: '04',
        isPaid: true,
      ),
    ];
  }

  List<PassengerModel> get filteredPassengers => passengers.where((p) {
    final query = searchQuery.value.toLowerCase();

    final matchesSearch =
        p.name.toLowerCase().contains(query) ||
        p.seatNumber.toString().toLowerCase().contains(query);

    bool matchesFilter = true;
    if (selectedFilter.value == 'PAID') {
      matchesFilter = p.isPaid == true;
    } else if (selectedFilter.value == 'UNPAID') {
      matchesFilter = p.isPaid == false;
    }

    return matchesSearch && matchesFilter;
  }).toList();

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

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
