import 'package:get/get.dart';

import '../../../../data/models/driver_model.dart';
import '../../../../data/models/trip_model.dart';
import '../../../../data/providers/profile_provider.dart';
import '../../../profile/controllers/profile_controller.dart';

class ScheduleController extends GetxController {
  final ProfileProvider _profileProvider = ProfileProvider();
  final ProfileController _profileController = Get.find<ProfileController>();
  Rxn<DriverModel> get driver => _profileController.driverData;
  var isLoading = true.obs;
  var trips = <TripModel>[].obs;
  var selectedStatus = 'ongoing'.obs;
  var currentIndex = 2.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDriverProfile();
    loadMockData();
  }

  Future<void> fetchDriverProfile() async {
    try {
      isLoading.value = true;
      final response = await _profileProvider.getProfile();
      if (response.statusCode == 200) {
        driver.value = DriverModel.fromJson(response.data['data']);
      }
    } catch (e) {
      print("Error: $e");
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

  void loadMockData() {
    trips.value = [
      TripModel(
        id: '1',
        pickupLocation: 'Cairo, Tahrir Sq.',
        destination: 'Alexandria, Station',
        time: '08:30 AM',
        status: 'ongoing',
        hasMap: true,
        passengerCount: "42/50",
        distance: "218 km",
      ),
      TripModel(
        id: '2',
        pickupLocation: 'Hurghada, Marina',
        destination: 'Cairo, Giza',
        time: '06:00 AM',
        status: 'upcoming',
        busNumber: '4442',
        passengerCount: "30/50",
        distance: "450 km",
      ),
      TripModel(
        id: '3',
        pickupLocation: 'Sharm El Sheikh',
        destination: 'Suez Terminal',
        time: 'May 26, 02:30 PM',
        status: 'upcoming',
        passengerCount: "30/50",
        distance: "450 km",
      ),
    ];
  }

  List<TripModel> get filteredTrips =>
      trips.where((trip) => trip.status == selectedStatus.value).toList();

  void changeStatus(String status) => selectedStatus.value = status;

  void changePage(int index) => currentIndex.value = index;

  void toggleDriverStatus() {
    if (driver.value != null) {
      String newStatus = driver.value!.status == "active"
          ? "offline"
          : "active";
      driver.value = driver.value!.copyWith(status: newStatus);

      // _authProvider.updateStatus(newStatus);
    }
  }

  void viewMap(TripModel trip) {
    Get.snackbar(
      'Map',
      'Opening map for ${trip.pickupLocation}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  String getStatusText(String status) => status.tr;
}
