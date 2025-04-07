import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../platform/platform_is.dart';

abstract class LocationService {
  static Future<LocationData?> getLocation() async {
    if (PlatformIs.web) {
      // Web specific implementation
      return _getWebLocation();
    } else {
      return _getMobileLocation();
    }
  }

  static Future<LocationData?> _getMobileLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

    // Check if the location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check if location permission is granted
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    // Get the location data
    locationData = await location.getLocation();
    return locationData;
  }

  static Future<LocationData?> _getWebLocation() async {
    // Web specific location logic (fallback to asking the user to enable location services)
    debugPrint('Web platform does not support location service directly.');
    return null;
  }
}
