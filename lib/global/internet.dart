import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final _internetConnectionChecker = InternetConnectionChecker.createInstance(addresses: [
  AddressCheckOptions(address: InternetAddress('142.250.179.132', type: InternetAddressType.IPv4)), // GoogleAPIs
  AddressCheckOptions(address: InternetAddress('1.1.1.1', type: InternetAddressType.IPv4)), // CloudFlare
  AddressCheckOptions(address: InternetAddress('2620:0:ccc::2', type: InternetAddressType.IPv6)), // OpenDNS
]);

class Internet {
  static StreamSubscription<InternetConnectionStatus>? _internetConnectionStatusSubscription;
  static InternetConnectionStatus? _lastInternetConnectionStatus;

  static Future init() async {
    if (kIsWeb) return;
    if (_lastInternetConnectionStatus == null) {
      _lastInternetConnectionStatus = await _internetConnectionChecker.connectionStatus;
      _internetConnectionStatusSubscription?.cancel();
      _internetConnectionStatusSubscription = internetConnectionStateStream.listen((status) => _lastInternetConnectionStatus = status);
    }
  }

  static Future<bool> hasInternetConnection() async {
    if (kIsWeb) return true;
    if (!(await _internetConnectionChecker.hasConnection)) return false;
    return true;
  }

  static Stream<InternetConnectionStatus> get internetConnectionStateStream {
    if (kIsWeb) return Stream.value(InternetConnectionStatus.connected);
    return _internetConnectionChecker.onStatusChange;
  }

  static InternetConnectionStatus? get lastInternetConnectionState {
    if (kIsWeb) return InternetConnectionStatus.connected;
    return _lastInternetConnectionStatus;
  }

  dispose() => _internetConnectionStatusSubscription?.cancel();
}
