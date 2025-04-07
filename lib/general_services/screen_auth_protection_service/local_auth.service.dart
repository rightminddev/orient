import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import '../../platform/platform_is.dart';

abstract class LocalAuthenticationService {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> isDeviceSupported() async {
    if (PlatformIs.mobile) {
      try {
        return await _auth.isDeviceSupported();
      } on PlatformException catch (e) {
        debugPrint("Error checking if device is supported: ${e.toString()}");
        return false;
      }
    }
    return false;
  }

  static Future<bool> canCheckBiometrics() async {
    if (PlatformIs.mobile) {
      try {
        return await _auth.canCheckBiometrics;
      } on PlatformException catch (e) {
        debugPrint("Error checking biometrics: ${e.toString()}");
        return false;
      }
    }
    return false;
  }

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    if (PlatformIs.mobile) {
      try {
        return await _auth.getAvailableBiometrics();
      } on PlatformException catch (e) {
        debugPrint("Error getting available biometrics: ${e.toString()}");
        return <BiometricType>[];
      }
    }
    return <BiometricType>[];
  }

  static Future<bool> authenticateWithBiometrics(
      {required String localizedReason}) async {
    if (PlatformIs.mobile) {
      try {
        return await _auth.authenticate(
          localizedReason: localizedReason,
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
        );
      } on PlatformException catch (e) {
        debugPrint("Error during biometric authentication: ${e.toString()}");
        return false;
      }
    }
    return false;
  }

  static Future<void> stopAuthentication() async {
    if (PlatformIs.mobile) {
      await _auth.stopAuthentication();
    }
  }
}
