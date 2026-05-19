import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/shared/custom_snackbar.dart';
import '../../../data/models/passenger_model.dart';
import '../../../data/repositories/booking_repository.dart';
import '../views/widgets/ticket_details_dialog.dart';

class PassengerController extends GetxController {
  final BookingRepository _bookingRepository = Get.find<BookingRepository>();

  var passengers = <PassengerModel>[].obs;
  var searchQuery = ''.obs;
  var currentScannedPassenger = Rxn<PassengerModel>();
  var selectedFilter = 'ALL'.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPassengers();
  }

  Future<void> processQrCode(String? pnrCode) async {
    if (pnrCode == null || pnrCode.isEmpty) {
      CustomSnackBar.showError("Invalid QR Code".tr);
      return;
    }

    isLoading.value = true;

    try {
      final passenger = await _bookingRepository.verifyTicket(pnrCode);
      currentScannedPassenger.value = passenger;

      Get.back();
      showTicketResult();
    } catch (error) {
      CustomSnackBar.showError(error.toString());
    } finally {
      isLoading.value = false;
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
        name: 'Ahmed Mansour',
        phoneNumber: '1234567890',
        seatNumbers: [1],
        status: 'confirmed',
      ),
      PassengerModel(
        name: 'Sarah Wilson',
        phoneNumber: '0987654321',
        seatNumbers: [2],
        status: 'pending',
      ),
    ];
  }

  List<PassengerModel> get filteredPassengers => passengers.where((p) {
    final query = searchQuery.value.toLowerCase();
    final matchesSearch =
        p.name.toLowerCase().contains(query) ||
        p.seatNumbersFormatted.toLowerCase().contains(query);

    bool matchesFilter = true;
    if (selectedFilter.value == 'PAID') {
      matchesFilter = p.status.toLowerCase() == 'confirmed';
    } else if (selectedFilter.value == 'UNPAID') {
      matchesFilter = p.status.toLowerCase() != 'confirmed';
    }

    return matchesSearch && matchesFilter;
  }).toList();

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void openTicketScanner() {
    Get.toNamed('/qr-scanner');
  }
}
