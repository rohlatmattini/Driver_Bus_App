import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../constants/app_link.dart';

class ApiService extends GetxService {
  late Dio dio;

  Future<ApiService> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: AppLink.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return this;
  }
}
