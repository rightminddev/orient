import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

abstract class ConnectionsService {
  static final Connectivity _connectivity = Connectivity();

  /// from this subscriber , i can handle , trigger and redirect by listen to certain connection type.
  static StreamSubscription<List<ConnectivityResult>>? _subscription;

  static Future<List<ConnectivityResult>> getAvailableConnections() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult;
  }

  static Stream<List<ConnectivityResult>> get connectionStream async* {
    await for (var result in _connectivity.onConnectivityChanged) {
      yield result;
    }
  }

  static void startListening(void Function(List<ConnectivityResult>) onData) {
    _subscription = connectionStream.listen(onData);
  }

  static void stopListening() {
    _subscription?.cancel();
  }

  static void handleConnectionType(
      List<ConnectivityResult> connectivityResults) {
    for (var result in connectivityResults) {
      if (result == ConnectivityResult.mobile) {
        debugPrint("Mobile network available.");
      } else if (result == ConnectivityResult.wifi) {
        debugPrint("Wi-Fi is available.");
      } else if (result == ConnectivityResult.ethernet) {
        debugPrint("Ethernet connection available.");
      } else if (result == ConnectivityResult.vpn) {
        debugPrint("VPN connection active.");
      } else if (result == ConnectivityResult.bluetooth) {
        debugPrint("Bluetooth connection available.");
      } else if (result == ConnectivityResult.other) {
        debugPrint(
            "Connected to a network which is not in the above mentioned networks.");
      } else if (result == ConnectivityResult.none) {
        debugPrint("No available network types.");
      }
    }
  }

  static Future<bool> isOnline() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      return !connectivityResult.contains(ConnectivityResult.none);
    } catch (e) {
      debugPrint('Error checking internet connection: $e');
      return false; // Assume offline on error
    }
  }

  static Future<void> init() async {
    final initialResults = await getAvailableConnections();
    handleConnectionType(initialResults);
  }

  static void dispose() {
    stopListening();
  }
}
