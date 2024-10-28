import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
// import 'package:wifi_scan/wifi_scan.dart';
import '../../general_services/alert_service/alerts.service.dart';
import '../../general_services/image_file_picker.service.dart';
import '../../general_services/settings.service.dart';
import '../../models/settings/general_settings.model.dart';
import '../../services/fingerprint_service.dart';
import 'widgets/qrcode_Scanner_view.widget.dart';
import 'package:location/location.dart' as location_package;

abstract class MainFabServices {
  static IconData getFingerprintMethodIcon(
      {required String fingerprintMethod}) {
    switch (fingerprintMethod.toLowerCase().trim()) {
      case 'fp_scan':
        return Icons.qr_code;
      case 'fp_navigate' || 'custom_fp_navigate':
        return Icons.gps_fixed_rounded;
      case 'fp_wifi':
        return Icons.wifi;
      case 'fp_bluetooth':
        return Icons.bluetooth_connected;
      case 'fp_machine':
        return Icons.fingerprint;
      default:
        return Icons.fingerprint;
    }
  }

  static Future<void> getFingerprintActionMethodDependsOnFingerprintMethod(
      {required BuildContext context,
      required String fingerprintMethod}) async {
    switch (fingerprintMethod.toLowerCase().trim()) {
      case 'fp_scan':
        await addFingerprintUsingQrCode(context: context);
        return;
      case 'fp_navigate' || 'custom_fp_navigate':
        await addFingerprintUsingGPS(context: context);
      case 'fp_wifi':
        await addFingerprintUsingWiFi(context: context);
      case 'fp_bluetooth':
        await addFingerprintUsingBluetooth(context: context);
      case 'fp_nfc':
        await addFingerprintUsingNFC(context: context);
      case 'fp_machine':
      default:
        AlertsService.error(
            context: context,
            message: 'Error Happeded ! Please try later !',
            title: 'Error');
    }
  }

  // Adding Fingerprint using NFC
  static Future<void> addFingerprintUsingNFC(
      {required BuildContext context}) async {
    try {
      final bool? fingerprintMustUploadImage = (AppSettingsService.getSettings(
              settingsType: SettingsType.generalSettings,
              context: context) as GeneralSettingsModel)
          .fingerprintMustUploadImage;
      FilePickerResult? empPhoto;
      if (fingerprintMustUploadImage == true) {
        empPhoto = await FileAndImagePickerService.pickImageWithFilePicker();
      }
      if (fingerprintMustUploadImage == true &&
          (empPhoto == null || empPhoto.files.first.bytes == null)) {
        AlertsService.error(
            context: context,
            message: 'Please Take Photo Before Adding Fingerprint',
            title: 'Photo Required!');
        return;
      }
      // Check if the device supports NFC
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (!isAvailable) {
        AlertsService.error(
            context: context,
            message: 'NFC is not supported or enabled on this device!',
            title: 'Error');
        return;
      }
      AlertsService.info(
          context: context,
          message: 'Please attach the device to the NFC chip',
          title: 'NFC');
      // Start NFC session
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          // Extract the UID, card content, and tag type
          String uid = tag.data['id']?.toString() ?? '0';
          String cardContent =
              '0'; // Placeholder, customize as per your card type
          String tagType = tag.data['type']?.toString() ?? '0';

          // Combine the UID, card content, and tag type
          String nfcData = '$uid-$cardContent-$tagType';

          // Stop the session
          NfcManager.instance.stopSession();

          // Send the combined data to the server
          final result = await FingerprintService.addNFCFingerprint(
              context: context,
              data: nfcData,
              files: empPhoto != null ? [empPhoto] : []);

          // Handle the server response
          if (result.success) {
            AlertsService.success(
                context: context,
                message: 'Fingerprint Added Successfully!',
                title: 'Success');
            return;
          } else {
            AlertsService.error(
                context: context,
                message: 'Failed to Add Fingerprint!',
                title: 'Error');
            return;
          }
        },
        onError: (NfcError error) {
          AlertsService.error(
              context: context,
              message: 'Error during NFC session: ${error.message}',
              title: 'Error');
          return NfcManager.instance.stopSession();
        },
      );
    } catch (e) {
      debugPrint('Error Adding NFC Fingerprint: $e');
      AlertsService.error(
          context: context,
          message: 'Error Happened! Please try later!',
          title: 'Error');
      return;
    }
  }

  static Future<void> addFingerprintUsingBluetooth({
    required BuildContext context,
  }) async {
    // try {
    //   final bool? fingerprintMustUploadImage = (AppSettingsService.getSettings(
    //           settingsType: SettingsType.generalSettings,
    //           context: context) as GeneralSettingsModel)
    //       .fingerprintMustUploadImage;
    //   FilePickerResult? empPhoto;
    //   if (fingerprintMustUploadImage == true) {
    //     empPhoto = await FileAndImagePickerService.pickImageWithFilePicker();
    //   }
    //   if (fingerprintMustUploadImage == true &&
    //       (empPhoto == null || empPhoto.files.first.bytes == null)) {
    //     AlertsService.error(
    //         context: context,
    //         message: 'Please Take Photo Before Adding Fingerprint',
    //         title: 'Photo Required!');
    //     return;
    //   }

    //   final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

    //   // Start scanning for Bluetooth devices
    //   flutterBlue.startScan(timeout: const Duration(seconds: 5));

    //   // Collect scan results
    //   final scanResults = await flutterBlue.scanResults.first;

    //   // Show available Bluetooth devices in a popup or sheet
    //   final selectedDevice = await showModalBottomSheet<ScanResult>(
    //     context: context,
    //     builder: (context) {
    //       return ListView.builder(
    //         itemCount: scanResults.length,
    //         itemBuilder: (context, index) {
    //           final result = scanResults[index];
    //           return ListTile(
    //             title: Text(result.device.name),
    //             subtitle: Text(result.device.id.toString()), // MAC address
    //             onTap: () => Navigator.pop(context, result),
    //           );
    //         },
    //       );
    //     },
    //   );

    //   if (selectedDevice == null) return;

    //   // Stop scanning once a device is selected
    //   flutterBlue.stopScan();

    //   // Send the MAC address to the server
    //   final bluetoothData = {
    //     'mac_address': selectedDevice.device.id.toString()
    //   };
    //   final result = await FingerprintService.addBluetoothFingerprint(
    //       context: context,
    //       data: bluetoothData.toString(),
    //       files: empPhoto != null ? [empPhoto] : []);

    //   // Handle the server response
    //   if (result.success) {
    //     AlertsService.success(
    //         context: context,
    //         message: 'Fingerprint Added Successfully!',
    //         title: 'Success');
    //     return;
    //   } else {
    //     AlertsService.error(
    //         context: context,
    //         message: 'Failed to Add Fingerprint!',
    //         title: 'Error');
    //     return;
    //   }
    // } catch (e) {
    //   debugPrint('Error Adding Bluetooth Fingerprint: $e');
    //   AlertsService.error(
    //       context: context,
    //       message: 'Error Happeded! Please try later!',
    //       title: 'Error');
    // }
  }

  // Adding Fingerprint Using Wifi
  static Future<void> addFingerprintUsingWiFi({
    required BuildContext context,
  }) async {
    // try {
    //   final bool? fingerprintMustUploadImage = (AppSettingsService.getSettings(
    //           settingsType: SettingsType.generalSettings,
    //           context: context) as GeneralSettingsModel)
    //       .fingerprintMustUploadImage;
    //   FilePickerResult? empPhoto;
    //   if (fingerprintMustUploadImage == true) {
    //     empPhoto = await FileAndImagePickerService.pickImageWithFilePicker();
    //   }
    //   if (fingerprintMustUploadImage == true &&
    //       (empPhoto == null || empPhoto.files.first.bytes == null)) {
    //     AlertsService.error(
    //         context: context,
    //         message: 'Please Take Photo Before Adding Fingerprint',
    //         title: 'Photo Required!');
    //     return;
    //   }
    //   // Check for Wi-Fi scan permissions
    //   final status = await WiFiScan.instance.canStartScan();
    //   if (status != CanStartScan.yes) {
    //     AlertsService.warning(
    //       context: context,
    //       message: 'Wi-Fi scan permission is required',
    //       title: 'Warning',
    //     );
    //     return;
    //   }

    //   // Start scanning for Wi-Fi networks
    //   await WiFiScan.instance.startScan();

    //   // Get the list of Wi-Fi networks
    //   final List<WiFiAccessPoint> wifiNetworks =
    //       await WiFiScan.instance.getScannedResults();

    //   if (wifiNetworks.isEmpty) {
    //     AlertsService.warning(
    //       context: context,
    //       message: 'No Wi-Fi networks found',
    //       title: 'Warning',
    //     );
    //     return;
    //   }

    //   // Show available Wi-Fi networks in a popup or sheet
    //   final selectedNetwork = await showModalBottomSheet<WiFiAccessPoint>(
    //     context: context,
    //     builder: (context) {
    //       return ListView.builder(
    //         itemCount: wifiNetworks.length,
    //         itemBuilder: (context, index) {
    //           final network = wifiNetworks[index];
    //           return ListTile(
    //             title: Text(network.ssid),
    //             subtitle: Text(network.bssid), // MAC address
    //             onTap: () => Navigator.pop(context, network),
    //           );
    //         },
    //       );
    //     },
    //   );

    //   if (selectedNetwork == null) return;

    //   // Prepare the data to send to the server
    //   final wifiData = {'mac_address': selectedNetwork.bssid};
    //   final result = await FingerprintService.addWifiFingerprint(
    //       context: context,
    //       data: wifiData.toString(),
    //       files: empPhoto != null ? [empPhoto] : []);

    //   // Handle the server response
    //   if (result.success) {
    //     AlertsService.success(
    //       context: context,
    //       message: 'Fingerprint Added Successfully!',
    //       title: 'Success',
    //     );
    //     return;
    //   } else {
    //     AlertsService.error(
    //       context: context,
    //       message: 'Failed to Add Fingerprint!',
    //       title: 'Error',
    //     );
    //     return;
    //   }
    // } catch (e) {
    //   debugPrint('Error Adding Wi-Fi Fingerprint: $e');
    //   AlertsService.error(
    //     context: context,
    //     message: 'An error occurred! Please try again later!',
    //     title: 'Error',
    //   );
    //   return;
    // }
  }

  // Add Fingerprint Using GPS
  static Future<void> addFingerprintUsingGPS({
    required BuildContext context,
  }) async {
    try {
      final bool? fingerprintMustUploadImage = (AppSettingsService.getSettings(
              settingsType: SettingsType.generalSettings,
              context: context) as GeneralSettingsModel)
          .fingerprintMustUploadImage;
      FilePickerResult? empPhoto;
      if (fingerprintMustUploadImage == true) {
        empPhoto = await FileAndImagePickerService.pickImageWithFilePicker();
      }
      if (fingerprintMustUploadImage == true &&
          (empPhoto == null || empPhoto.files.first.bytes == null)) {
        AlertsService.error(
            context: context,
            message: 'Please Take Photo Before Adding Fingerprint',
            title: 'Photo Required!');
        return;
      }

      final location_package.Location location = location_package.Location();

      // Check if location services are enabled
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          AlertsService.warning(
              context: context,
              message: 'Location services are disabled',
              title: 'Warning');
          return;
        }
      }

      // Check for location permission
      location_package.PermissionStatus permissionGranted =
          await location.hasPermission();
      if (permissionGranted == location_package.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != location_package.PermissionStatus.granted) {
          AlertsService.warning(
              context: context,
              message: 'Location permission is required',
              title: 'Warning');
          return;
        }
      }

      // Get user's current location
      final location_package.LocationData locationData =
          await location.getLocation();

      if (locationData.latitude == null || locationData.longitude == null) {
        AlertsService.error(
            context: context,
            message:
                'Unable to get location, please enable location services and grant permission.',
            title: 'Error');
        return;
      }

      // Call the Fingerprint Service to add the GPS fingerprint
      final result = await FingerprintService.addGPSFingerprint(
          context: context,
          type: 'fp_navigate',
          lat: locationData.latitude!,
          long: locationData.longitude!,
          files: empPhoto != null ? [empPhoto] : []);

      // Handle the server response
      if (result.success) {
        AlertsService.success(
            context: context,
            message: 'Fingerprint Added Successfully!',
            title: 'Success');
        return;
      } else {
        AlertsService.error(
            context: context,
            message: 'Failed to Add Fingerprint!',
            title: 'Error');
        return;
      }
    } catch (e) {
      debugPrint('Error Adding GPS Fingerprint: $e');
      AlertsService.error(
          context: context,
          message: 'Error Happeded! Please try later!',
          title: 'Error');
      return;
    }
  }

  // Add Fingerprint Using QrCode
  static Future<void> addFingerprintUsingQrCode(
      {required BuildContext context}) async {
    try {
      final bool? fingerprintMustUploadImage = (AppSettingsService.getSettings(
              settingsType: SettingsType.generalSettings,
              context: context) as GeneralSettingsModel)
          .fingerprintMustUploadImage;
      FilePickerResult? empPhoto;
      // if (fingerprintMustUploadImage == true) {
      if (false) {
        empPhoto = await FileAndImagePickerService.pickImageWithFilePicker();
      }
      // if (fingerprintMustUploadImage == true &&
      //     (empPhoto == null || empPhoto.files.first.bytes == null)) {
      if (false) {
        AlertsService.error(
            context: context,
            message: 'Please Take Photo Before Adding Fingerprint',
            title: 'Photo Required!');
        return;
      }
      final String? scanedQrCode =
          await _scanQrcodeToGetSecretKeyString(context: context);
      if (scanedQrCode == null || scanedQrCode.isEmpty) return;
      // Call Your Fingerprint Scanner API
      final result = await FingerprintService.addQRCodeFingerprint(
          context: context,
          data: scanedQrCode,
          files: empPhoto != null ? [empPhoto] : []);
      if (result.success) {
        AlertsService.success(
            context: context,
            message: 'Fingerprint Added Successfully!',
            title: 'Success');
        return;
      } else {
        AlertsService.error(
            context: context,
            message: 'Failed to Add Fingerprint!',
            title: 'Error');
        return;
      }
    } catch (e) {
      debugPrint(
          'Error Happeded While Adding Fingerprint Using Qrcode! Error :-> $e');
      AlertsService.error(
          context: context,
          message: 'Error Happeded! Please try later!',
          title: 'Error');
    }
  }

  static Future<String?> _scanQrcodeToGetSecretKeyString(
      {required BuildContext context}) async {
    try {
      // Request camera permission
      var cameraStatus = await permission_handler.Permission.camera.request();
      if (!cameraStatus.isGranted) {
        AlertsService.warning(
            context: context,
            message: 'Camera permission is required to scan QR codes',
            title: 'Warning');
        return null;
      }

      // Initialize a GlobalKey for the QRView widget
      final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
      // Use a Navigator to push a full-screen scanner widget
      // final result = await Navigator.push<String?>(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => QRScannerView(qrKey: qrKey),
      //   ),
      // );
      // If scanning was successful, return the scanned text
    //  return result;
    } catch (e) {
      // Handle any errors, return null in case of an error
      debugPrint('Error scanning QR code: $e');
      AlertsService.error(
          context: context,
          message: 'Error Happeded! Please try later!',
          title: 'Error');
      return null;
    }
    return null;
  }
}
