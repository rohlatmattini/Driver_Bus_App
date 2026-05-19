import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../core/services/api_service.dart';

class BookingProvider extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  Future<Response> verifyTicket(String pnrCode) async {
    try {
      final response = await _apiService.dio.post(
        '/driver/bookings/verify',
        data: {"pnr_code": pnrCode},
      );
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? e.message;
    } catch (e) {
      throw e.toString();
    }
  }
}
