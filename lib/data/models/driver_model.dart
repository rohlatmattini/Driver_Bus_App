class DriverModel {
  final String id;
  final String name;
  final bool isOnline;
  final String? avatar;

  DriverModel({
    required this.id,
    required this.name,
    required this.isOnline,
    this.avatar,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      isOnline: json['isOnline'] ?? false,
      avatar: json['avatar'],
    );
  }
}