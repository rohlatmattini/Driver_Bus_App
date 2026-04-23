class PassengerModel {
  final String id;
  final String name;
  final String seatNumber;
  final bool isPaid;
  final String? route;

  PassengerModel({required this.id, required this.name, required this.seatNumber, required this.isPaid, this.route});

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
      id: json['id'],
      name: json['name'],
      seatNumber: json['seatNumber'],
      isPaid: json['isPaid'] ?? false,
      route: json['route'],
    );
  }
}