import 'package:get/get.dart';
import '../../data/providers/auth_provider.dart';
import '../../data/models/login_model.dart';

class AuthRepository {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  Future<LoginResponseModel> login(LoginModel loginModel) async {
    try {
      final response = await _authProvider.login(loginModel.toJson());

      if (response.statusCode == 200) {
        if (response.body['success'] == true) {
          _authProvider.saveToken(response.body['token']);
          return LoginResponseModel.fromJson(response.body);
        } else {
          return LoginResponseModel(
            success: false,
            message: response.body['message'] ?? 'Login failed',
          );
        }
      } else {
        return LoginResponseModel(
          success: false,
          message: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      return LoginResponseModel(
        success: false,
        message: 'Network error: $e',
      );
    }
  }

  void logout() {
    _authProvider.clearToken();
  }
}