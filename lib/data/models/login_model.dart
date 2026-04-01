class LoginModel {
  final String username;
  final String password;

  LoginModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}

class LoginResponseModel {
  final bool success;
  final String? message;
  final String? token;
  final UserData? userData;

  LoginResponseModel({
    required this.success,
    this.message,
    this.token,
    this.userData,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      message: json['message'],
      token: json['token'],
      userData: json['userData'] != null
          ? UserData.fromJson(json['userData'])
          : null,
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String employeeId;
  final String license;
  final int experience;
  final String avatar;

  UserData({
    required this.id,
    required this.name,
    required this.employeeId,
    required this.license,
    required this.experience,
    required this.avatar,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      employeeId: json['employeeId'] ?? '',
      license: json['license'] ?? '',
      experience: json['experience'] ?? 0,
      avatar: json['avatar'] ?? '',
    );
  }
}