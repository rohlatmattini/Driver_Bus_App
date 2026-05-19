import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/shared/custom_snackbar.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/repositories/trip_repository.dart';

class TripDetailsController extends GetxController {
  final TripRepository _tripRepository = Get.find<TripRepository>();

  var routeId = "".obs;
  var pickupLocation = "".obs;
  var destination = "".obs;
  var departureTime = "".obs;
  var arrivalTime = "".obs;
  var passengerCount = "".obs;
  var distance = "".obs;
  var fare = "".obs;
  var duration = "".obs;
  var vehicleNumber = "".obs;

  var tripStatus = "Start".obs;
  var tripStatusDisplay = "".obs;
  var statusColor = Colors.grey.obs;
  var isUpdating = false.obs;
  final List<String> tripStatusOptions = [
    'scheduled',
    'in_progress',
    'completed',
    'cancelled',
  ];

  TripModel? currentTrip;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      currentTrip = Get.arguments as TripModel;
      _loadTripData();
    }
  }

  void _loadTripData() {
    if (currentTrip == null) return;

    final trip = currentTrip!;
    routeId.value = "#TR-${trip.id}";
    pickupLocation.value = trip.pickupLocation;
    destination.value = trip.destination;
    departureTime.value = trip.departureTimeFormatted;
    arrivalTime.value = trip.arrivalTimeFormatted;
    passengerCount.value = trip.passengerCount;
    distance.value = trip.distanceFormatted;
    fare.value = trip.fareFormatted;
    duration.value = trip.tripDuration;
    vehicleNumber.value = trip.vehicleNumber;
    tripStatusDisplay.value = trip.statusDisplayName;

    tripStatus.value = trip.status;
  }

  void updateTripStatus(String? newValue) {
    if (newValue != null) tripStatus.value = newValue;
  }

  Future<void> startTripAction() async {
    if (currentTrip == null) return;

    String newStatus;
    String successMessage;
    String confirmMessage;

    switch (tripStatus.value) {
      case 'scheduled':
        newStatus = 'in_progress';
        confirmMessage = 'Are you sure you want to start this trip?';
        successMessage = 'Trip started successfully';
        break;
      case 'in_progress':
        newStatus = 'completed';
        confirmMessage =
            'Are you sure you want to mark this trip as completed?';
        successMessage = 'Trip completed successfully';
        break;
      default:
        CustomSnackBar.showError(
          'Cannot update trip status from ${tripStatusDisplay.value}',
        );
        return;
    }

    bool? confirm = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Confirm'.tr),
        content: Text(confirmMessage.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel'.tr, style: TextStyle(color: AppColor.error)),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryGreen,
            ),
            child: Text('Confirm'.tr),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      isUpdating.value = true;

      final updatedTrip = await _tripRepository.updateTripStatus(
        tripId: currentTrip!.id,
        status: newStatus,
      );

      currentTrip = updatedTrip;
      _loadTripData();

      CustomSnackBar.showSuccess(successMessage);
    } catch (e) {
      CustomSnackBar.showError('Failed to update trip status: $e');
    } finally {
      isUpdating.value = false;
    }
  }

  String get actionButtonText {
    switch (tripStatus.value) {
      case 'scheduled':
        return 'startTrip'.tr;
      case 'in_progress':
        return 'endTrip'.tr;
      case 'completed':
        return 'completed'.tr;
      case 'cancelled':
        return 'cancelled'.tr;
      default:
        return 'updateStatus'.tr;
    }
  }

  bool get canUpdateStatus {
    return tripStatus.value == 'scheduled' || tripStatus.value == 'in_progress';
  }
}
