class AppLink {
  static const String baseUrl = "https://syria-travel.app/api";

  // Auth
  static const String sendOtp = "$baseUrl/auth/otp/send";
  static const String verifyOtp = "$baseUrl/auth/otp/verify";
  static const String loginOtp = "$baseUrl/auth/otp/login";

  //Profile
  static const String driverProfile = "$baseUrl/driver/profile";

  // Trips
  static const String driverTrips = "$baseUrl/driver/trips";

  // Update Trip Status
  static String updateTripStatus(int tripId) =>
      "$baseUrl/driver/trips/$tripId/status";
}
