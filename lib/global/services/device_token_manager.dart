import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:travel_hero/repositories/user_repository.dart';

class DeviceTokenManager {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final UserRepository _userRepository;

  DeviceTokenManager(this._userRepository);

  /// Initializes the device token manager by getting the token and listening for refresh.
  Future<void> initialize() async {
    await _getDeviceToken();

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) async {
      log("🔄 Refreshed token: $newToken");
      await _updateDeviceToken(newToken);
    });
  }

  /// Retrieves the device token and updates the user record.
  Future<void> _getDeviceToken() async {
    try {
      String? token = await _messaging.getToken();
      if (token != null) {
        log("📲 Initial device token: $token");
        await _updateDeviceToken(token);
      } else {
        log("❌ Failed to obtain device token.");
      }
    } catch (e) {
      log("⚠️ Error getting device token: $e");
    }
  }

  /// Updates the user device token in the repository.
  Future<void> _updateDeviceToken(String token) async {
    final result = await _userRepository.updateUserDeviceToken(token);
    result.fold(
          (error) => log("❌ Error updating token: ${error.message}"),
          (updatedUser) => log("✅ User updated with token successfully."),
    );
  }
}