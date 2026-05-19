import 'package:get/get.dart';

import '../../../../core/shared/custom_snackbar.dart';
import '../../../../data/models/driver_model.dart';
import '../../../../data/models/trip_model.dart';
import '../../../../data/providers/profile_provider.dart';
import '../../../../data/repositories/trip_repository.dart';
import '../../../profile/controllers/profile_controller.dart';

class ScheduleController extends GetxController {
  final ProfileProvider _profileProvider = ProfileProvider();
  final TripRepository _tripRepository;
  final ProfileController _profileController = Get.find<ProfileController>();
  Rxn<DriverModel> get driver => _profileController.driverData;
  var isLoading = true.obs;
  var trips = <TripModel>[].obs;
  var selectedStatus = 'ongoing'.obs;
  var currentIndex = 2.obs;

  ScheduleController({required TripRepository tripRepository})
    : _tripRepository = tripRepository;

  @override
  void onInit() {
    super.onInit();
    fetchDriverProfile();
    fetchTrips();
  }

  Future<void> fetchDriverProfile() async {
    try {
      final response = await _profileProvider.getProfile();
      if (response.statusCode == 200) {
        _profileController.driverData.value = DriverModel.fromJson(
          response.data['data'],
        );
      }
    } catch (e) {
      print("Error fetching profile: \$e");
    }
  }

  Future<void> fetchTrips({int page = 1}) async {
    try {
      isLoading.value = true;
      final fetchedTrips = await _tripRepository.getDriverTrips(page: page);
      trips.value = fetchedTrips;
    } catch (e) {
      print("Error fetching trips: $e");
      CustomSnackBar.showError('Failed to load trips');
    } finally {
      isLoading.value = false;
    }
  }

  final List<String> statusOptions = [
    'ongoing',
    'upcoming',
    'completed',
    'cancelled',
  ];

  List<TripModel> get filteredTrips =>
      trips.where((trip) => trip.mappedStatus == selectedStatus.value).toList();

  void changeStatus(String status) => selectedStatus.value = status;

  void changePage(int index) => currentIndex.value = index;

  void toggleDriverStatus() {
    if (_profileController.driverData.value != null) {
      String newStatus = _profileController.driverData.value!.status == "active"
          ? "offline"
          : "active";

      _profileController.driverData.value = _profileController.driverData.value!
          .copyWith(status: newStatus);

      CustomSnackBar.showSuccess(
        newStatus == "active"
            ? "You are now Online".tr
            : "You are now Offline".tr,
      );
    }
  }

  void viewMap(TripModel trip) {
    CustomSnackBar.showSuccess('Opening map for ${trip.pickupLocation}');
  }

  String getStatusText(String status) => status.tr;
}
