import 'package:get/get.dart';

class TripModel {
  final int id;
  final String status;
  final DateTime departureTime;
  final DateTime estimatedArrivalTime;
  final int baseFare;
  final int availableSeats;
  final int routeId;
  final int vehicleId;
  final int driverId;
  final int originStationId;
  final int destinationStationId;
  final int originCityId;
  final int destinationCityId;
  final City originCity;
  final City destinationCity;
  final Station originStation;
  final Station destinationStation;
  final DateTime createdAt;
  final DateTime updatedAt;

  TripModel({
    required this.id,
    required this.status,
    required this.departureTime,
    required this.estimatedArrivalTime,
    required this.baseFare,
    required this.availableSeats,
    required this.routeId,
    required this.vehicleId,
    required this.driverId,
    required this.originStationId,
    required this.destinationStationId,
    required this.originCityId,
    required this.destinationCityId,
    required this.originCity,
    required this.destinationCity,
    required this.originStation,
    required this.destinationStation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      status: json['status'],
      departureTime: DateTime.parse(json['departure_time']),
      estimatedArrivalTime: DateTime.parse(json['estimated_arrival_time']),
      baseFare: json['base_fare'],
      availableSeats: json['available_seats'],
      routeId: json['route_id'],
      vehicleId: json['vehicle_id'],
      driverId: json['driver_id'],
      originStationId: json['origin_station_id'],
      destinationStationId: json['destination_station_id'],
      originCityId: json['origin_city_id'],
      destinationCityId: json['destination_city_id'],
      originCity: City.fromJson(json['origin_city']),
      destinationCity: City.fromJson(json['destination_city']),
      originStation: Station.fromJson(json['origin_station']),
      destinationStation: Station.fromJson(json['destination_station']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'departure_time': departureTime.toIso8601String(),
      'estimated_arrival_time': estimatedArrivalTime.toIso8601String(),
      'base_fare': baseFare,
      'available_seats': availableSeats,
      'route_id': routeId,
      'vehicle_id': vehicleId,
      'driver_id': driverId,
      'origin_station_id': originStationId,
      'destination_station_id': destinationStationId,
      'origin_city_id': originCityId,
      'destination_city_id': destinationCityId,
      'origin_city': originCity.toJson(),
      'destination_city': destinationCity.toJson(),
      'origin_station': originStation.toJson(),
      'destination_station': destinationStation.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  TripModel copyWith({
    int? id,
    String? status,
    DateTime? departureTime,
    DateTime? estimatedArrivalTime,
    int? baseFare,
    int? availableSeats,
    int? routeId,
    int? vehicleId,
    int? driverId,
    int? originStationId,
    int? destinationStationId,
    int? originCityId,
    int? destinationCityId,
    City? originCity,
    City? destinationCity,
    Station? originStation,
    Station? destinationStation,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? mappedStatus,
  }) {
    return TripModel(
      id: id ?? this.id,
      status: mappedStatus ?? status ?? this.status,
      departureTime: departureTime ?? this.departureTime,
      estimatedArrivalTime: estimatedArrivalTime ?? this.estimatedArrivalTime,
      baseFare: baseFare ?? this.baseFare,
      availableSeats: availableSeats ?? this.availableSeats,
      routeId: routeId ?? this.routeId,
      vehicleId: vehicleId ?? this.vehicleId,
      driverId: driverId ?? this.driverId,
      originStationId: originStationId ?? this.originStationId,
      destinationStationId: destinationStationId ?? this.destinationStationId,
      originCityId: originCityId ?? this.originCityId,
      destinationCityId: destinationCityId ?? this.destinationCityId,
      originCity: originCity ?? this.originCity,
      destinationCity: destinationCity ?? this.destinationCity,
      originStation: originStation ?? this.originStation,
      destinationStation: destinationStation ?? this.destinationStation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get pickupLocation => "${originStation.name}, ${originCity.name}";
  String get destination =>
      "${destinationStation.name}, ${destinationCity.name}";
  String get fullRoute => "${originCity.name} ➔ ${destinationCity.name}";
  String get stationRoute =>
      "${originStation.name} ➔ ${destinationStation.name}";

  String get departureTimeFormatted => _formatDateTime(departureTime);
  String get arrivalTimeFormatted => _formatDateTime(estimatedArrivalTime);
  String get distanceFormatted =>
      "${originCity.name} - ${destinationCity.name}";

  String get tripDuration {
    final duration = estimatedArrivalTime.difference(departureTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  String get passengerCount => "$availableSeats/45";
  String get fareFormatted => "$baseFare SYP";
  bool get hasMap => status == 'in_progress';
  String get vehicleNumber => "Bus #$vehicleId";

  String get mappedStatus {
    switch (status) {
      case 'in_progress':
        return 'ongoing';
      case 'scheduled':
        final now = DateTime.now();
        return departureTime.isAfter(now) ? 'upcoming' : 'completed';
      case 'completed':
        return 'completed';
      case 'cancelled':
        return 'cancelled';
      default:
        return status;
    }
  }

  String get statusDisplayName {
    switch (status) {
      case 'in_progress':
        return 'in_progress'.tr;
      case 'scheduled':
        final now = DateTime.now();
        return departureTime.isAfter(now) ? 'upcoming'.tr : 'completed'.tr;
      case 'completed':
        return 'completed'.tr;
      case 'cancelled':
        return 'cancelled'.tr;
      default:
        return status;
    }
  }

  static String _formatDateTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final displayHour = hour == 0 ? 12 : hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, $displayHour:$minute $period';
  }
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Station {
  final int id;
  final String name;

  Station({required this.id, required this.name});

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
