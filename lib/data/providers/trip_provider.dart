import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../core/constants/app_link.dart';
import '../../core/services/api_service.dart';

class TripProvider {
  final Dio _dio = Get.find<ApiService>().dio;

  Future<Response> getDriverTrips({int page = 1}) async {
    return await _dio.get(AppLink.driverTrips, queryParameters: {'page': page});
  }

  Future<Response> updateTripStatus({
    required int tripId,
    required String status,
  }) async {
    return await _dio.patch(
      AppLink.updateTripStatus(tripId),
      data: {"status": status},
    );
  }
}
