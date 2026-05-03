import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../core/constants/app_link.dart';
import '../../core/services/api_service.dart';

class AuthProvider {
  final Dio _dio = Get.find<ApiService>().dio;

  Future<Response> sendOtp(String phone) async {
    return await _dio.post(
      AppLink.sendOtp,
      data: {"phone_number": phone, "intent": "passenger"},
    );
  }

  Future<Response> loginWithOtp(String phone, String code) async {
    return await _dio.post(
      AppLink.loginOtp,
      data: {"phone_number": phone, "code": code, "intent": "passenger"},
    );
  }
}
