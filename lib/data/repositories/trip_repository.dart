import '../models/trip_model.dart';
import '../providers/trip_provider.dart';

class TripRepository {
  final TripProvider _provider;

  TripRepository(this._provider);

  Future<List<TripModel>> getDriverTrips({int page = 1}) async {
    final response = await _provider.getDriverTrips(page: page);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => TripModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trips');
    }
  }

  Future<TripModel> updateTripStatus({
    required int tripId,
    required String status,
  }) async {
    final response = await _provider.updateTripStatus(
      tripId: tripId,
      status: status,
    );

    if (response.statusCode == 200) {
      return TripModel.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to update trip status');
    }
  }
}
