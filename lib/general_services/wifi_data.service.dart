import 'package:network_info_plus/network_info_plus.dart';
import 'package:flutter/services.dart';

/* Example :- Usage of this service .
-------------------------------------
void main() async {
  NetworkService networkService = NetworkService();
  Map<String, String> networkInfo = await networkService.getNetworkInfo();
  print(networkInfo);
}
*/

abstract class NetworkService {
  static final NetworkInfo _networkInfo = NetworkInfo();

  static Future<Map<String, String>> getNetworkInfo() async {
    Map<String, String> connectionStatus = {};

    try {
      // Get Wi-Fi name (SSID)
      connectionStatus['wifi_name'] = await _getWifiName();

      // Get Wi-Fi BSSID
      connectionStatus['wifi_bssid'] = await _getWifiBSSID();

      // Get Wi-Fi IP address (IPv4)
      connectionStatus['wifi_ipv4'] =
          await _networkInfo.getWifiIP() ?? 'Failed to get Wi-Fi IPv4';

      // Get Wi-Fi IPv6 address
      connectionStatus['wifi_ipv6'] =
          await _networkInfo.getWifiIPv6() ?? 'Failed to get Wi-Fi IPv6';

      // Get Wi-Fi broadcast address
      connectionStatus['wifi_broadcast'] =
          await _networkInfo.getWifiBroadcast() ??
              'Failed to get Wi-Fi broadcast';

      // Get Wi-Fi gateway IP
      connectionStatus['wifi_gateway'] =
          await _networkInfo.getWifiGatewayIP() ??
              'Failed to get Wi-Fi gateway';

      // Get Wi-Fi subnet mask
      connectionStatus['wifi_sub_mask'] = await _networkInfo.getWifiSubmask() ??
          'Failed to get Wi-Fi subnet mask';
    } catch (e) {
      // Handle any unexpected exceptions
      connectionStatus['error'] = 'Failed to get network info: $e';
    }

    return connectionStatus;
  }

  static Future<String> _getWifiName() async {
    try {
      return await _networkInfo.getWifiName() ?? 'Failed to get Wi-Fi Name';
    } on PlatformException {
      return 'Failed to get Wi-Fi Name';
    } catch (err, t) {
      return 'Permission denied for Wi-Fi Name $err $t';
    }
  }

  static Future<String> _getWifiBSSID() async {
    try {
      return await _networkInfo.getWifiBSSID() ?? 'Failed to get Wi-Fi BSSID';
    } on PlatformException {
      return 'Failed to get Wi-Fi BSSID';
    } catch (err, t) {
      return 'Permission denied for Wi-Fi BSSID $err in $t';
    }
  }
}
