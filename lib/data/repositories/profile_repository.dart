import 'package:dio/dio.dart';

import '../providers/profile_provider.dart';

class ProfileRepository {
  final ProfileProvider _provider;
  ProfileRepository(this._provider);

  Future<Response> getDriverProfile() => _provider.getProfile();
  Future<Response> updateDriverProfile({
    required String name,
    required String phone,
    required String email,
    String? imagePath,
  }) async {
    if (imagePath != null && imagePath.isNotEmpty) {
      FormData formData = FormData.fromMap({
        "name": name,
        "phone_number": phone,
        "email": email,
        "avatar": await MultipartFile.fromFile(
          imagePath,
          filename: "avatar.jpg",
        ),
      });
      return _provider.updateProfileMultipart(formData);
    } else {
      return _provider.updateProfileJson({
        "name": name,
        "phone_number": phone,
        "email": email,
      });
    }
  }
}
