import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;
import '../models/device_information.model.dart';
import '../platform/platform_is.dart';
import 'app_config.service.dart';

abstract class DeviceInformationService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  static Future<String?> getCurrentPlatformId() async {
    try {
      String? deviceIdentifier;

      if (PlatformIs.android) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        deviceIdentifier = androidInfo.id;
      } else if (PlatformIs.iOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        deviceIdentifier = iosInfo.identifierForVendor;
      } else if (PlatformIs.web) {
        // The web doesnt have a device UID, so use a combination fingerprint as an example
        WebBrowserInfo webInfo = await _deviceInfo.webBrowserInfo;
        deviceIdentifier = webInfo.vendor! +
            (webInfo.userAgent ?? "") +
            webInfo.hardwareConcurrency.toString();
      } else if (PlatformIs.linux) {
        LinuxDeviceInfo linuxInfo = await _deviceInfo.linuxInfo;
        deviceIdentifier = linuxInfo.machineId;
      }
      // deviceIdentifier = ConfigService.getValueString("deviceIdentifier");
      // if (deviceIdentifier.isEmpty) {
      //   deviceIdentifier = DateTime.now().microsecondsSinceEpoch.toString();
      //   ConfigService.setValueString("deviceIdentifier", deviceIdentifier);
      // }
      return deviceIdentifier;
    } catch (ex) {
      return null;
    }
  }

  static Future<String> getDeviceBrand() async {
    if (PlatformIs.android) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.brand;
    } else if (PlatformIs.iOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    } else if (PlatformIs.web) {
      WebBrowserInfo webInfo = await _deviceInfo.webBrowserInfo;
      return 'Web: ${webInfo.userAgent}';
    }
    return 'Unknown Device Brand';
  }

  static Future<String> getOperatingSystem() async {
    if (PlatformIs.android) {
      return 'Android';
    } else if (PlatformIs.iOS) {
      return 'iOS';
    } else if (PlatformIs.web) {
      return 'Web';
    }
    return 'Unknown Operating System';
  }

  static Future<String> getOperatingSystemVersion() async {
    if (PlatformIs.android) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return 'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';
    } else if (PlatformIs.iOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return 'iOS ${iosInfo.systemVersion} (${iosInfo.utsname.machine})';
    } else if (PlatformIs.web) {
      return html.window.navigator.userAgent;
    }
    return 'Unknown Operating System Version';
  }

  /// called in startup of the application to set locally all device information.
  static Future<void> initializeAndSetDeviceInfo(
      {required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    Map<String, dynamic> deviceInfoMap = {
      'operating_system': await getOperatingSystem(),
      'operating_system_version': await getOperatingSystemVersion(),
      'brand': await getDeviceBrand(),
      'language': context.locale.languageCode,
      'device_unique_id': await getCurrentPlatformId(),
      'type': PlatformIs.getCurrentPlatformType(),
    };
    // set device information in App Configuration Service
    appConfigServiceProvider.deviceInformation =
        DeviceInfo.fromMap(deviceInfoMap);
  }
}
