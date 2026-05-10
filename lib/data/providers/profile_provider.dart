import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:get_storage/get_storage.dart';

import '../../core/constants/app_link.dart';
import '../../core/services/api_service.dart';

class ProfileProvider {
  final Dio _dio = Get.find<ApiService>().dio;
  final GetStorage _box = GetStorage();

  Future<Response> getProfile() async {
    String? token = _box.read("token");
    return await _dio.get(
      AppLink.driverProfile,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<Response> updateProfileJson(Map<String, dynamic> data) async {
    String? token = _box.read("token");
    return await _dio.patch(
      AppLink.driverProfile,
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<Response> updateProfileMultipart(FormData data) async {
    String? token = _box.read("token");
    return await _dio.post(
      AppLink.driverProfile,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }
}
