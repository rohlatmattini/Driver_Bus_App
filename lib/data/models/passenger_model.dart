class PassengerModel {
  final String name;
  final String phoneNumber;
  final List<int> seatNumbers;
  final String status;

  PassengerModel({
    required this.name,
    required this.phoneNumber,
    required this.seatNumbers,
    required this.status,
  });

  PassengerModel.old({
    required this.name,
    required this.phoneNumber,
    required this.seatNumbers,
    required this.status,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
      name: json['name'],
      phoneNumber: json['phone_number'],
      seatNumbers: List<int>.from(json['seat_numbers']),
      status: json['status'],
    );
  }

  String get seatNumbersFormatted => seatNumbers.join(', ');

  bool get isPaid => status.toLowerCase() == 'confirmed';
}
