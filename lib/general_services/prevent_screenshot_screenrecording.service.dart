import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';
import '../platform/platform_is.dart';

abstract class PreventScreenShotAndScreenRecording {
  static Future<void> enable() async {
    if (PlatformIs.android) {
      _enableAndroid();
    } else if (PlatformIs.iOS) {
      _enableIOS();
    } else if (PlatformIs.web) {
      _enableWeb();
    }
  }

  /// Android: The WindowManager.LayoutParams.FLAG_SECURE flag prevents screenshots and screen recording.
  static void _enableAndroid() {
    // Add the FLAG_SECURE to the Android window
    const platform = MethodChannel('${AppConstants.appPackageName}/secure');
    platform.invokeMethod('enableSecureFlag');
  }

  /// use a method channel to create an overlay that hides the screen content.
  static void _enableIOS() {
    // iOS specific implementation
    const platform = MethodChannel('${AppConstants.appPackageName}app/secure');
    platform.invokeMethod('enableSecureFlag');
  }

  /// Detecting and preventing screen captures is complex; you can only alert the user as shown.
  static void _enableWeb() {
    // Web specific implementation
    // Display a warning or overlay to alert the user
    debugPrint('Web platform does not support screen capture prevention');
  }
}
