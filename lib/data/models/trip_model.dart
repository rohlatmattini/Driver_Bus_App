class TripModel {
  final String id;
  final String pickupLocation;
  final String destination;
  final String time;
  final String status;
  final String? busNumber;
  final bool hasMap;
  final String? passengerCount;
  final String? distance;

  TripModel({
    required this.id,
    required this.pickupLocation,
    required this.destination,
    required this.time,
    required this.status,
    this.busNumber,
    this.hasMap = false,
    this.passengerCount,
    this.distance,
  });
}