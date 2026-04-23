import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthProvider extends GetConnect {
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR_BASE_URL';

    httpClient.addRequestModifier<dynamic>((request) {
      String? token = _storage.read('token');
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    super.onInit();
  }

  Future<Response> login(Map<String, dynamic> data) async {
    return await post('/login', data);
  }

  void saveToken(String token) {
    _storage.write('token', token);
  }

  void clearToken() {
    _storage.remove('token');
  }
}