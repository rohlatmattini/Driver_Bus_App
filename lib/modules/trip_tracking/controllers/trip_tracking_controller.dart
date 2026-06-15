// import 'dart:async';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';
//
// import '../../../core/constants/app_color.dart';
// import '../../../core/shared/custom_snackbar.dart';
// import '../../../data/models/rest_area_model.dart';
// import '../../../data/models/station_model.dart';
// import '../../../data/models/trip_model.dart';
// import '../../../data/repositories/trip_repository.dart';
//
// class TripTrackingController extends GetxController {
//   final int tripId;
//   TripTrackingController({required this.tripId});
//
//   var isMapReady = false.obs;
//   var polylinePoints = <LatLng>[].obs;
//   var markers = <Marker>[].obs;
//   var busLocation = Rxn<LatLng>();
//   var isLoading = true.obs;
//   var isOnline = true.obs;
//
//   var routeDistance = "".obs;
//   var routeDuration = "".obs;
//
//   var autoFollow = true.obs;
//
//   var heading = 0.0.obs;
//
//   var etaTime = "".obs;
//
//   var tripDestinationName = "".obs;
//
//   // ✅ بيانات الرحلة الحالية (نحتاجها لمعرفة الحالة status)
//   TripModel? currentTrip;
//
//   // ✅ حالة الرحلة بشكل Reactive لإظهار/إخفاء زر "إنهاء الرحلة"
//   var isTripInProgress = false.obs;
//
//   // ✅ حالة جاري تحديث الحالة (إنهاء الرحلة)
//   var isEndingTrip = false.obs;
//
//   LatLng? _lastKnownGoodLocation;
//
//   late MapController mapController;
//   StreamSubscription<Position>? positionStream;
//   StreamSubscription? _connectivitySubscription;
//   final Connectivity _connectivity = Connectivity();
//
//   // ✅ مؤقت إرسال موقع السائق إلى السيرفر
//   Timer? _locationPingTimer;
//
//   @override
//   void onInit() {
//     super.onInit();
//     polylinePoints.clear();
//     markers.clear();
//     mapController = MapController();
//     _checkInitialConnectivity();
//   }
//
//   Future<void> _checkInitialConnectivity() async {
//     final List<ConnectivityResult> result = await _connectivity
//         .checkConnectivity();
//     if (result.isNotEmpty) {
//       isOnline.value = result.first != ConnectivityResult.none;
//     }
//
//     await fetchTripDetails();
//     await _startTracking();
//
//     _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
//       results,
//     ) {
//       if (results.isNotEmpty) {
//         isOnline.value = results.first != ConnectivityResult.none;
//       }
//     });
//   }
//
//   @override
//   void onClose() {
//     positionStream?.cancel();
//     _connectivitySubscription?.cancel();
//     _locationPingTimer?.cancel();
//     mapController.dispose();
//     super.onClose();
//   }
//
//   Future<void> _startTracking() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       debugPrint("❌ GPS service is OFF");
//       CustomSnackBar.showError("gps_disabled_error".tr);
//       return;
//     }
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         CustomSnackBar.showError("location_permission_denied".tr);
//         return;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       debugPrint("❌ Location permission permanently denied");
//       CustomSnackBar.showError("location_permission_permanently_denied".tr);
//       return;
//     }
//
//     try {
//       final Position current = await Geolocator.getCurrentPosition(
//         locationSettings: AndroidSettings(
//           accuracy: LocationAccuracy.high,
//           forceLocationManager: false,
//           timeLimit: const Duration(seconds: 10),
//         ),
//       );
//
//       debugPrint(
//         "📍 Fresh GPS: ${current.latitude}, ${current.longitude}"
//         " | accuracy: ${current.accuracy}m",
//       );
//
//       if (current.accuracy <= 150) {
//         final pos = LatLng(current.latitude, current.longitude);
//         _lastKnownGoodLocation = pos;
//         busLocation.value = pos;
//       } else {
//         debugPrint(
//           "⚠️ Still inaccurate (${current.accuracy}m), waiting for stream...",
//         );
//       }
//     } catch (e) {
//       debugPrint("❌ getCurrentPosition failed: $e");
//     }
//
//     positionStream =
//         Geolocator.getPositionStream(
//           locationSettings: AndroidSettings(
//             accuracy: LocationAccuracy.bestForNavigation,
//             forceLocationManager: true,
//             distanceFilter: 10,
//           ),
//         ).listen(
//           (Position position) {
//             debugPrint(
//               "🔄 Stream pos: ${position.latitude}, ${position.longitude} | acc: ${position.accuracy}m",
//             );
//
//             if (position.accuracy > 50) return;
//
//             final newPos = LatLng(position.latitude, position.longitude);
//
//             if (busLocation.value != null) {
//               final double distanceMoved = const Distance().as(
//                 LengthUnit.Meter,
//                 busLocation.value!,
//                 newPos,
//               );
//
//               if (distanceMoved < 10) {
//                 debugPrint("⏳ الجهاز ثابت تقريباً — تم تجاهل الاهتزاز");
//                 return;
//               }
//
//               if (_lastKnownGoodLocation != null) {
//                 final double metersFromGood = const Distance().as(
//                   LengthUnit.Meter,
//                   _lastKnownGoodLocation!,
//                   newPos,
//                 );
//                 if (metersFromGood > 50000) {
//                   debugPrint("🚫 Location jump detected: rejected");
//                   return;
//                 }
//               }
//             }
//
//             if (busLocation.value != null && position.speed > 1.0) {
//               heading.value = position.heading;
//             }
//
//             _lastKnownGoodLocation = newPos;
//             busLocation.value = newPos;
//             _updateETA();
//
//             if (isMapReady.value && autoFollow.value) {
//               mapController.move(busLocation.value!, mapController.camera.zoom);
//             }
//           },
//           onError: (error) {
//             debugPrint('❌ خطأ في بث الموقع: $error');
//             if (error.toString().contains('disabled')) {
//               CustomSnackBar.showError("gps_turned_off_during_trip".tr);
//             }
//           },
//         );
//   }
//
//   void onMapReady() {
//     isMapReady.value = true;
//     Future.delayed(const Duration(milliseconds: 500), () {
//       updateCamera();
//     });
//   }
//
//   void updateCamera() {
//     if (!isMapReady.value) return;
//
//     if (polylinePoints.length >= 2) {
//       mapController.fitCamera(
//         CameraFit.coordinates(
//           coordinates: polylinePoints,
//           padding: const EdgeInsets.all(100),
//         ),
//       );
//     } else if (busLocation.value != null) {
//       mapController.move(busLocation.value!, 12.0);
//     } else if (polylinePoints.isNotEmpty) {
//       mapController.move(polylinePoints.first, 12.0);
//     }
//   }
//
//   void _updateETA() {
//     if (routeDuration.value.isEmpty) return;
//     final now = DateTime.now();
//
//     final parts = routeDuration.value
//         .replaceAll(" ", "")
//         .split(RegExp(r"[سد]"));
//
//     int hours = 0, minutes = 0;
//     if (parts.length >= 2) {
//       hours = int.tryParse(parts[0]) ?? 0;
//       minutes = int.tryParse(parts[1]) ?? 0;
//     } else if (routeDuration.value.contains("دقيقة") ||
//         routeDuration.value.contains("د")) {
//       minutes = int.tryParse(parts[0]) ?? 0;
//     }
//
//     final eta = now.add(Duration(hours: hours, minutes: minutes));
//     final h = eta.hour > 12 ? eta.hour - 12 : eta.hour;
//     final displayH = h == 0 ? 12 : h;
//     final m = eta.minute.toString().padLeft(2, "0");
//     final period = eta.hour >= 12 ? "pm_period".tr : "am_period".tr;
//
//     etaTime.value = "$displayH:$m $period";
//   }
//
//   Future<void> fetchTripDetails() async {
//     isLoading.value = true;
//     polylinePoints.clear();
//     markers.clear();
//     busLocation.value = null;
//     routeDistance.value = "";
//     routeDuration.value = "";
//
//     try {
//       final repo = Get.find<TripRepository>();
//
//       final List<TripModel> trips = await repo.getDriverTrips(
//         page: 1,
//         isOnline: isOnline.value,
//       );
//       final TripModel? trip = trips.firstWhereOrNull((t) => t.id == tripId);
//
//       if (trip == null) {
//         debugPrint("❌ Trip not found: id=$tripId");
//         return;
//       }
//
//       // ✅ نحفظ الرحلة الحالية لاستخدام حالتها (status) لاحقاً
//       currentTrip = trip;
//       isTripInProgress.value = trip.status.toLowerCase() == 'in_progress';
//
//       final List<dynamic> rawStations = await repo.getStations(
//         isOnline: isOnline.value,
//       );
//       final List<dynamic> rawRestAreas = await repo.getRestAreas(
//         isOnline: isOnline.value,
//       );
//
//       final List<StationModel> allStations = rawStations
//           .map((json) => StationModel.fromJson(json))
//           .toList();
//       final List<RestAreaModel> allRestAreas = rawRestAreas
//           .map((json) => RestAreaModel.fromJson(json))
//           .toList();
//
//       List<LatLng> waypoints = [];
//       List<Map<String, dynamic>> waypointInfo = [];
//
//       var startStation = allStations.firstWhere(
//         (s) => s.id == trip.originStation?.id,
//         orElse: () =>
//             StationModel(id: 0, name: "", latitude: 0.0, longitude: 0.0),
//       );
//       if (startStation.latitude != null && startStation.latitude != 0.0) {
//         final point = LatLng(startStation.latitude!, startStation.longitude!);
//         waypoints.add(point);
//         waypointInfo.add({
//           'point': point,
//           'type': 'start',
//           'name': startStation.name,
//         });
//       }
//
//       for (var area in trip.restAreas) {
//         var match = allRestAreas.firstWhere(
//           (r) => r.id == (area.restAreaId ?? area.id),
//           orElse: () => RestAreaModel(
//             id: -1,
//             name: "",
//             description: "",
//             rating: 0.0,
//             ratingCount: 0,
//             latitude: 0.0,
//             longitude: 0.0,
//           ),
//         );
//         if (match.id != -1 && match.latitude != null && match.latitude != 0.0) {
//           final point = LatLng(match.latitude!, match.longitude!);
//           waypoints.add(point);
//           waypointInfo.add({
//             'point': point,
//             'type': 'rest',
//             'name': match.name,
//           });
//         }
//       }
//
//       var endStation = allStations.firstWhere(
//         (s) => s.id == trip.destinationStation?.id,
//         orElse: () =>
//             StationModel(id: 0, name: "", latitude: 0.0, longitude: 0.0),
//       );
//       if (endStation.latitude != null && endStation.latitude != 0.0) {
//         final point = LatLng(endStation.latitude!, endStation.longitude!);
//         waypoints.add(point);
//         waypointInfo.add({
//           'point': point,
//           'type': 'end',
//           'name': endStation.name,
//         });
//         tripDestinationName.value = endStation.name;
//       }
//
//       if (waypoints.length >= 2 && isOnline.value) {
//         final String coordsString = waypoints
//             .map((p) => "${p.longitude},${p.latitude}")
//             .join(';');
//         final String url =
//             "https://router.project-osrm.org/route/v1/driving/$coordsString"
//             "?overview=full&geometries=geojson";
//
//         final response = await Dio().get(url);
//         if (response.statusCode == 200) {
//           final route = response.data['routes'][0];
//
//           final double distanceMeters = (route['distance'] as num).toDouble();
//           final double durationSeconds = (route['duration'] as num).toDouble();
//
//           final double distanceKm = distanceMeters / 1000;
//           final int hours = (durationSeconds / 3600).floor();
//           final int minutes = ((durationSeconds % 3600) / 60).floor();
//
//           routeDistance.value = distanceKm >= 1
//               ? "${distanceKm.toStringAsFixed(1)} ${"unit_km".tr}"
//               : "${distanceMeters.toStringAsFixed(0)} ${"unit_m".tr}";
//
//           routeDuration.value = hours > 0
//               ? "$hours ${"unit_hour".tr} $minutes ${"unit_minute".tr}"
//               : "$minutes ${"unit_minutes_only".tr}";
//
//           _updateETA();
//
//           final List<dynamic> coords = route['geometry']['coordinates'];
//           polylinePoints.assignAll(
//             coords.map((c) => LatLng(c[1], c[0])).toList(),
//           );
//         }
//       } else if (!isOnline.value && waypoints.length >= 2) {
//         polylinePoints.assignAll(waypoints);
//       }
//
//       List<Marker> newMarkers = [];
//       for (var info in waypointInfo) {
//         final LatLng point = info['point'];
//         final String type = info['type'];
//         final String name = info['name'];
//
//         if (type == 'start') {
//           newMarkers.add(
//             Marker(
//               point: point,
//               width: 100,
//               height: 55,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 6,
//                       vertical: 2,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColor.success,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Text(
//                       name,
//                       style: const TextStyle(
//                         color: AppColor.white,
//                         fontSize: 9,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const Icon(
//                     Icons.location_on,
//                     color: AppColor.success,
//                     size: 30,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else if (type == 'rest') {
//           newMarkers.add(
//             Marker(
//               point: point,
//               width: 100,
//               height: 55,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 6,
//                       vertical: 2,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColor.orange,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Text(
//                       name,
//                       style: const TextStyle(
//                         color: AppColor.white,
//                         fontSize: 9,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const Icon(Icons.coffee, color: AppColor.orange, size: 28),
//                 ],
//               ),
//             ),
//           );
//         } else if (type == 'end') {
//           newMarkers.add(
//             Marker(
//               point: point,
//               width: 100,
//               height: 55,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 6,
//                       vertical: 2,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColor.error,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Text(
//                       name,
//                       style: const TextStyle(
//                         color: AppColor.white,
//                         fontSize: 9,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const Icon(Icons.flag, color: AppColor.error, size: 30),
//                 ],
//               ),
//             ),
//           );
//         }
//       }
//
//       markers.assignAll(newMarkers);
//
//       Future.delayed(const Duration(milliseconds: 300), () {
//         updateCamera();
//       });
//     } catch (e) {
//       debugPrint("❌ Error in fetchTripDetails: $e");
//     } finally {
//       isLoading.value = false;
//       // ✅ بعد جلب تفاصيل الرحلة، نقرر إذا نبدأ/نوقف إرسال الموقع
//       _manageLocationPing();
//     }
//   }
//
//   // ================== Driver Location Ping ==================
//
//   /// يشغّل أو يوقف مؤقت إرسال الموقع حسب حالة الرحلة الحالية (status == in_progress)
//   void _manageLocationPing() {
//     _locationPingTimer?.cancel();
//     _locationPingTimer = null;
//
//     if (isTripInProgress.value) {
//       debugPrint("🟢 الرحلة قيد التنفيذ — بدء إرسال الموقع كل 8 ثواني");
//
//       // إرسال فوري أول مرة (إن وُجد موقع جاهز)
//       _sendLocationPing();
//
//       _locationPingTimer = Timer.periodic(
//         const Duration(seconds: 8),
//         (_) => _sendLocationPing(),
//       );
//     } else {
//       debugPrint(
//         "⏸️ حالة الرحلة '${currentTrip?.status}' — لن يتم إرسال الموقع",
//       );
//     }
//   }
//
//   /// يرسل آخر موقع GPS معروف للسيرفر عبر الـ Repository (Fire-and-forget، 202 Accepted)
//   Future<void> _sendLocationPing() async {
//     final pos = busLocation.value;
//     if (pos == null) return;
//
//     if (!isOnline.value) {
//       debugPrint("📴 لا يوجد اتصال — تم تجاهل إرسال الموقع");
//       return;
//     }
//
//     final repo = Get.find<TripRepository>();
//     final bool sent = await repo.sendTripLocation(
//       tripId: tripId,
//       lat: pos.latitude,
//       lng: pos.longitude,
//       isOnline: isOnline.value,
//     );
//
//     if (sent) {
//       debugPrint("📡 تم إرسال الموقع (${pos.latitude}, ${pos.longitude})");
//     } else {
//       debugPrint("❌ فشل إرسال الموقع للسيرفر");
//     }
//   }
//
//   // ================== End Trip Action ==================
//
//   /// إنهاء الرحلة الحالية (in_progress -> completed) مباشرة من شاشة الخريطة.
//   /// نفس منطق TripDetailsController.startTripAction() عند الحالة in_progress.
//   Future<void> endTripAction() async {
//     if (currentTrip == null) return;
//     if (!isTripInProgress.value) return;
//     if (isEndingTrip.value) return;
//
//     bool? confirm = await Get.dialog<bool>(
//       AlertDialog(
//         title: Text('Confirm'.tr),
//         content: Text('confirm_end_trip_message'.tr),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(result: false),
//             child: Text('Cancel'.tr, style: TextStyle(color: AppColor.error)),
//           ),
//           ElevatedButton(
//             onPressed: () => Get.back(result: true),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColor.primaryGreen,
//             ),
//             child: Text('Confirm'.tr),
//           ),
//         ],
//       ),
//     );
//
//     if (confirm != true) return;
//
//     try {
//       isEndingTrip.value = true;
//
//       final repo = Get.find<TripRepository>();
//       final updatedTrip = await repo.updateTripStatus(
//         tripId: tripId,
//         status: 'completed',
//         isOnline: isOnline.value,
//       );
//
//       currentTrip = updatedTrip;
//       isTripInProgress.value =
//           updatedTrip.status.toLowerCase() == 'in_progress';
//
//       // ✅ نوقف إرسال الموقع فوراً، لا حاجة لانتظار onClose
//       _locationPingTimer?.cancel();
//       _locationPingTimer = null;
//
//       CustomSnackBar.showSuccess(
//         isOnline.value
//             ? 'trip_completed_successfully'.tr
//             : 'trip_completed_locally'.tr,
//       );
//
//       Get.back();
//     } catch (e) {
//       CustomSnackBar.showError(
//         'failed_to_update_trip_status'.trParams({'error': e.toString()}),
//       );
//     } finally {
//       isEndingTrip.value = false;
//     }
//   }
// }

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/shared/custom_snackbar.dart';
import '../../../data/models/rest_area_model.dart';
import '../../../data/models/station_model.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/repositories/trip_repository.dart';

class TripTrackingController extends GetxController {
  final int tripId;
  TripTrackingController({required this.tripId});

  var isMapReady = false.obs;
  var polylinePoints = <LatLng>[].obs;
  var markers = <Marker>[].obs;
  var busLocation = Rxn<LatLng>();
  var isLoading = true.obs;
  var isOnline = true.obs;

  var routeDistance = "".obs;
  var routeDuration = "".obs;

  var autoFollow = true.obs;

  var heading = 0.0.obs;

  var etaTime = "".obs;

  var tripDestinationName = "".obs;

  // ✅ بيانات الرحلة الحالية (نحتاجها لمعرفة الحالة status)
  TripModel? currentTrip;

  // ✅ حالة الرحلة بشكل Reactive لإظهار/إخفاء زر "إنهاء الرحلة"
  var isTripInProgress = false.obs;

  // ✅ حالة جاري تحديث الحالة (إنهاء الرحلة)
  var isEndingTrip = false.obs;

  LatLng? _lastKnownGoodLocation;

  late MapController mapController;
  StreamSubscription<Position>? positionStream;
  StreamSubscription? _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  // ✅ مؤقت إرسال موقع السائق إلى السيرفر
  Timer? _locationPingTimer;

  @override
  void onInit() {
    super.onInit();
    polylinePoints.clear();
    markers.clear();
    mapController = MapController();
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    final List<ConnectivityResult> result = await _connectivity
        .checkConnectivity();
    if (result.isNotEmpty) {
      isOnline.value = result.first != ConnectivityResult.none;
    }

    await fetchTripDetails();
    await _startTracking();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      if (results.isNotEmpty) {
        isOnline.value = results.first != ConnectivityResult.none;
      }
    });
  }

  @override
  void onClose() {
    positionStream?.cancel();
    _connectivitySubscription?.cancel();
    _locationPingTimer?.cancel();
    mapController.dispose();
    super.onClose();
  }

  Future<void> _startTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("❌ GPS service is OFF");
      CustomSnackBar.showError("gps_disabled_error".tr);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CustomSnackBar.showError("location_permission_denied".tr);
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      debugPrint("❌ Location permission permanently denied");
      CustomSnackBar.showError("location_permission_permanently_denied".tr);
      return;
    }

    try {
      final Position current = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.high,
          forceLocationManager: false,
          timeLimit: const Duration(seconds: 10),
        ),
      );

      debugPrint(
        "📍 Fresh GPS: ${current.latitude}, ${current.longitude}"
        " | accuracy: ${current.accuracy}m",
      );

      // رفعنا الدقة المبدئية المسموحة لـ 200 متر لتناسب تغطية الشبكات المحلية
      if (current.accuracy <= 200) {
        final pos = LatLng(current.latitude, current.longitude);
        _lastKnownGoodLocation = pos;
        busLocation.value = pos;
      } else {
        debugPrint(
          "⚠️ Still inaccurate (${current.accuracy}m), waiting for stream...",
        );
      }
    } catch (e) {
      debugPrint("❌ getCurrentPosition failed: $e");
    }

    positionStream =
        Geolocator.getPositionStream(
          locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.bestForNavigation,
            forceLocationManager: true,
            distanceFilter: 5, // تقليل المسافة المفلترة لقط اللمسات البسيطة
          ),
        ).listen(
          (Position position) {
            debugPrint(
              "🔄 Stream pos: ${position.latitude}, ${position.longitude} | acc: ${position.accuracy}m",
            );

            // 🛠️ التعديل الجوهري: تم رفع الحد المسموح للدقة إلى 150 متر بدلاً من 50
            // لكي لا يتم تجاهل إحداثيات الموبايل الحية عندما يعتمد على الأبراج
            if (position.accuracy > 150) {
              debugPrint(
                "⏳ تم تجاهل الإحداثية بسبب ضعف الدقة الزائد عن 150 متر",
              );
              return;
            }

            final newPos = LatLng(position.latitude, position.longitude);

            if (busLocation.value != null) {
              final double distanceMoved = const Distance().as(
                LengthUnit.Meter,
                busLocation.value!,
                newPos,
              );

              // السماح بالتحديث المستمر طالما هناك تغير ملموس
              if (distanceMoved < 5) {
                debugPrint("⏳ الجهاز ثابت تقريباً — تم تجاهل الاهتزاز");
                return;
              }

              if (_lastKnownGoodLocation != null) {
                final double metersFromGood = const Distance().as(
                  LengthUnit.Meter,
                  _lastKnownGoodLocation!,
                  newPos,
                );
                if (metersFromGood > 50000) {
                  debugPrint("🚫 Location jump detected: rejected");
                  return;
                }
              }
            }

            if (busLocation.value != null && position.speed > 1.0) {
              heading.value = position.heading;
            }

            _lastKnownGoodLocation = newPos;
            busLocation.value = newPos;
            _updateETA();

            if (isMapReady.value && autoFollow.value) {
              mapController.move(busLocation.value!, mapController.camera.zoom);
            }
          },
          onError: (error) {
            debugPrint('❌ خطأ في بث الموقع: $error');
            if (error.toString().contains('disabled')) {
              CustomSnackBar.showError("gps_turned_off_during_trip".tr);
            }
          },
        );
  }

  void onMapReady() {
    isMapReady.value = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      updateCamera();
    });
  }

  void updateCamera() {
    if (!isMapReady.value) return;

    if (polylinePoints.length >= 2) {
      mapController.fitCamera(
        CameraFit.coordinates(
          coordinates: polylinePoints,
          padding: const EdgeInsets.all(100),
        ),
      );
    } else if (busLocation.value != null) {
      mapController.move(busLocation.value!, 12.0);
    } else if (polylinePoints.isNotEmpty) {
      mapController.move(polylinePoints.first, 12.0);
    }
  }

  void _updateETA() {
    if (routeDuration.value.isEmpty) return;
    final now = DateTime.now();

    final parts = routeDuration.value
        .replaceAll(" ", "")
        .split(RegExp(r"[سد]"));

    int hours = 0, minutes = 0;
    if (parts.length >= 2) {
      hours = int.tryParse(parts[0]) ?? 0;
      minutes = int.tryParse(parts[1]) ?? 0;
    } else if (routeDuration.value.contains("دقيقة") ||
        routeDuration.value.contains("د")) {
      minutes = int.tryParse(parts[0]) ?? 0;
    }

    final eta = now.add(Duration(hours: hours, minutes: minutes));
    final h = eta.hour > 12 ? eta.hour - 12 : eta.hour;
    final displayH = h == 0 ? 12 : h;
    final m = eta.minute.toString().padLeft(2, "0");
    final period = eta.hour >= 12 ? "pm_period".tr : "am_period".tr;

    etaTime.value = "$displayH:$m $period";
  }

  Future<void> fetchTripDetails() async {
    isLoading.value = true;
    polylinePoints.clear();
    markers.clear();
    busLocation.value = null;
    routeDistance.value = "";
    routeDuration.value = "";

    try {
      final repo = Get.find<TripRepository>();

      final List<TripModel> trips = await repo.getDriverTrips(
        page: 1,
        isOnline: isOnline.value,
      );
      final TripModel? trip = trips.firstWhereOrNull((t) => t.id == tripId);

      if (trip == null) {
        debugPrint("❌ Trip not found: id=$tripId");
        return;
      }

      currentTrip = trip;
      isTripInProgress.value = trip.status.toLowerCase() == 'in_progress';

      final List<dynamic> rawStations = await repo.getStations(
        isOnline: isOnline.value,
      );
      final List<dynamic> rawRestAreas = await repo.getRestAreas(
        isOnline: isOnline.value,
      );

      final List<StationModel> allStations = rawStations
          .map((json) => StationModel.fromJson(json))
          .toList();
      final List<RestAreaModel> allRestAreas = rawRestAreas
          .map((json) => RestAreaModel.fromJson(json))
          .toList();

      List<LatLng> waypoints = [];
      List<Map<String, dynamic>> waypointInfo = [];

      var startStation = allStations.firstWhere(
        (s) => s.id == trip.originStation?.id,
        orElse: () =>
            StationModel(id: 0, name: "", latitude: 0.0, longitude: 0.0),
      );
      if (startStation.latitude != null && startStation.latitude != 0.0) {
        final point = LatLng(startStation.latitude!, startStation.longitude!);
        waypoints.add(point);
        waypointInfo.add({
          'point': point,
          'type': 'start',
          'name': startStation.name,
        });
      }

      for (var area in trip.restAreas) {
        var match = allRestAreas.firstWhere(
          (r) => r.id == (area.restAreaId ?? area.id),
          orElse: () => RestAreaModel(
            id: -1,
            name: "",
            description: "",
            rating: 0.0,
            ratingCount: 0,
            latitude: 0.0,
            longitude: 0.0,
          ),
        );
        if (match.id != -1 && match.latitude != null && match.latitude != 0.0) {
          final point = LatLng(match.latitude!, match.longitude!);
          waypoints.add(point);
          waypointInfo.add({
            'point': point,
            'type': 'rest',
            'name': match.name,
          });
        }
      }

      var endStation = allStations.firstWhere(
        (s) => s.id == trip.destinationStation?.id,
        orElse: () =>
            StationModel(id: 0, name: "", latitude: 0.0, longitude: 0.0),
      );
      if (endStation.latitude != null && endStation.latitude != 0.0) {
        final point = LatLng(endStation.latitude!, endStation.longitude!);
        waypoints.add(point);
        waypointInfo.add({
          'point': point,
          'type': 'end',
          'name': endStation.name,
        });
        tripDestinationName.value = endStation.name;
      }

      if (waypoints.length >= 2 && isOnline.value) {
        final String coordsString = waypoints
            .map((p) => "${p.longitude},${p.latitude}")
            .join(';');
        final String url =
            "https://router.project-osrm.org/route/v1/driving/$coordsString"
            "?overview=full&geometries=geojson";

        final response = await Dio().get(url);
        if (response.statusCode == 200) {
          final route = response.data['routes'][0];

          final double distanceMeters = (route['distance'] as num).toDouble();
          final double durationSeconds = (route['duration'] as num).toDouble();

          final double distanceKm = distanceMeters / 1000;
          final int hours = (durationSeconds / 3600).floor();
          final int minutes = ((durationSeconds % 3600) / 60).floor();

          routeDistance.value = distanceKm >= 1
              ? "${distanceKm.toStringAsFixed(1)} ${"unit_km".tr}"
              : "${distanceMeters.toStringAsFixed(0)} ${"unit_m".tr}";

          routeDuration.value = hours > 0
              ? "$hours ${"unit_hour".tr} $minutes ${"unit_minute".tr}"
              : "$minutes ${"unit_minutes_only".tr}";

          _updateETA();

          final List<dynamic> coords = route['geometry']['coordinates'];
          polylinePoints.assignAll(
            coords.map((c) => LatLng(c[1], c[0])).toList(),
          );
        }
      } else if (!isOnline.value && waypoints.length >= 2) {
        polylinePoints.assignAll(waypoints);
      }

      List<Marker> newMarkers = [];
      for (var info in waypointInfo) {
        final LatLng point = info['point'];
        final String type = info['type'];
        final String name = info['name'];

        if (type == 'start') {
          newMarkers.add(
            Marker(
              point: point,
              width: 100,
              height: 55,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.success,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 9,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.location_on,
                    color: AppColor.success,
                    size: 30,
                  ),
                ],
              ),
            ),
          );
        } else if (type == 'rest') {
          newMarkers.add(
            Marker(
              point: point,
              width: 100,
              height: 55,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 9,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.coffee, color: AppColor.orange, size: 28),
                ],
              ),
            ),
          );
        } else if (type == 'end') {
          newMarkers.add(
            Marker(
              point: point,
              width: 100,
              height: 55,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.error,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 9,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.flag, color: AppColor.error, size: 30),
                ],
              ),
            ),
          );
        }
      }

      markers.assignAll(newMarkers);

      Future.delayed(const Duration(milliseconds: 300), () {
        updateCamera();
      });
    } catch (e) {
      debugPrint("❌ Error in fetchTripDetails: $e");
    } finally {
      isLoading.value = false;
      _manageLocationPing();
    }
  }

  // ================== Driver Location Ping ==================

  void _manageLocationPing() {
    _locationPingTimer?.cancel();
    _locationPingTimer = null;

    if (isTripInProgress.value) {
      debugPrint("🟢 الرحلة قيد التنفيذ — بدء إرسال الموقع كل 8 ثواني");
      _sendLocationPing();

      _locationPingTimer = Timer.periodic(
        const Duration(seconds: 8),
        (_) => _sendLocationPing(),
      );
    } else {
      debugPrint(
        "⏸️ حالة الرحلة '${currentTrip?.status}' — لن يتم إرسال الموقع",
      );
    }
  }

  Future<void> _sendLocationPing() async {
    final pos = busLocation.value;
    if (pos == null) return;

    if (!isOnline.value) {
      debugPrint("📴 لا يوجد اتصال — تم تجاهل إرسال الموقع");
      return;
    }

    final repo = Get.find<TripRepository>();
    final bool sent = await repo.sendTripLocation(
      tripId: tripId,
      lat: pos.latitude,
      lng: pos.longitude,
      isOnline: isOnline.value,
    );

    if (sent) {
      debugPrint(
        "📡 تم إرسال الموقع الحقيقي للمخدم (${pos.latitude}, ${pos.longitude})",
      );
    } else {
      debugPrint("❌ فشل إرسال الموقع للسيرفر");
    }
  }

  // ================== End Trip Action ==================

  Future<void> endTripAction() async {
    if (currentTrip == null) return;
    if (!isTripInProgress.value) return;
    if (isEndingTrip.value) return;

    bool? confirm = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Confirm'.tr),
        content: Text('confirm_end_trip_message'.tr),
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
      isEndingTrip.value = true;

      final repo = Get.find<TripRepository>();
      final updatedTrip = await repo.updateTripStatus(
        tripId: tripId,
        status: 'completed',
        isOnline: isOnline.value,
      );

      currentTrip = updatedTrip;
      isTripInProgress.value =
          updatedTrip.status.toLowerCase() == 'in_progress';

      _locationPingTimer?.cancel();
      _locationPingTimer = null;

      CustomSnackBar.showSuccess(
        isOnline.value
            ? 'trip_completed_successfully'.tr
            : 'trip_completed_locally'.tr,
      );

      Get.back();
    } catch (e) {
      CustomSnackBar.showError(
        'failed_to_update_trip_status'.trParams({'error': e.toString()}),
      );
    } finally {
      isEndingTrip.value = false;
    }
  }
}
