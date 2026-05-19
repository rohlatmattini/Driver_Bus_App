import 'package:get/get.dart';

import '../../data/models/passenger_model.dart';
import '../../data/providers/booking_provider.dart';

class BookingRepository extends GetxService {
  final BookingProvider _bookingProvider = Get.find<BookingProvider>();

  Future<PassengerModel> verifyTicket(String pnrCode) async {
    final response = await _bookingProvider.verifyTicket(pnrCode);

    if (response.statusCode == 200) {
      final passengerData = response.data['data']['passenger'];

      final List<int> seatNumbers = List<int>.from(
        response.data['data']['seat_numbers'],
      );

      final status = response.data['data']['status'];

      return PassengerModel(
        name: passengerData['name'],
        phoneNumber: passengerData['phone_number'],
        seatNumbers: seatNumbers,
        status: status,
      );
    } else {
      throw response.data['message'] ?? 'Verification failed';
    }
  }
}
