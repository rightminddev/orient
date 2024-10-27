import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../general_services/backend_services/api_service/dio_api_service/dio_api.service.dart';
import '../general_services/backend_services/get_endpoint.service.dart';
import '../general_services/connections.service.dart';
import '../general_services/db_hive.service.dart';
import '../models/endpoint.model.dart';
import '../models/operation_result.model.dart';

enum Order { asc, desc }

abstract class FingerprintService {
  // Fetch a single fingerprint by ID
  static Future<OperationResult<Map<String, dynamic>>> getFingerprint({
    required BuildContext context,
    required String id,
  }) async {
    final url =
        '${EndpointServices.getApiEndpoint(EndpointsNames.getFingerprint).url}/$id';
    return await DioApiService().get<Map<String, dynamic>>(
      url,
      dataKey: 'data',
      context: context,
      allData: true,
    );
  }

  /// Fetch all fingerprints with optional parameters
  static Future<OperationResult<Map<String, dynamic>>> getFingerprints({
    required BuildContext context,
    String? pfor,
    DateTime? from,
    DateTime? to,
    int? page,
    String? orderBy,
    Order order = Order.asc,
    String? status,
  }) async {
    final DateTime currentDate = DateTime.now();

    // Default to current date if 'to' is not provided
    final DateTime toDate = to ?? currentDate;

    // Default to 'toDate - 1 months' if 'from' is not provided
    final DateTime fromDate =
        from ?? DateTime(toDate.year, toDate.month - 1, 2);

    // Custom date formatting to 'YYYY-M-D'
    String formatDate(DateTime date) {
      return '${date.year}-${date.month}-${date.day}';
    }

    // Build the base URL
    final baseUrl =
        EndpointServices.getApiEndpoint(EndpointsNames.getFingerprints).url;

    // Build query parameters
    final Map<String, String> params = {
      if (pfor != null) 'pfor': pfor,
      'from': formatDate(fromDate),
      'to': formatDate(toDate),
      if (page != null) 'page': page.toString(),
      if (orderBy != null) 'orderby': orderBy,
      'order': order == Order.asc ? 'asc' : 'desc',
      if (status != null) 'status': status,
    };

    // Construct the final URL with query parameters
    final queryParams =
        params.entries.map((e) => '${e.key}=${e.value}').join('&');
    final url = queryParams.isEmpty ? baseUrl : '$baseUrl?$queryParams';

    // Send the request
    final response = await DioApiService().get<Map<String, dynamic>>(
      url,
      dataKey: 'data',
      context: context,
      allData: true,
    );

    return response;
  }

  // Upload Stored Fingerprints to Server in online mood
  static Future<void> uploadFingerprintsInOnlineMood(
      {required BuildContext context}) async {
    try {
      if (await ConnectionsService.isOnline() == false) return;
      final savedFingerprints = await DBHiveService.getSavedFingerprints();
      if (savedFingerprints.isEmpty) return;
      final result = await _addFingerprints(
          context: context, fingerprints: savedFingerprints);
      if (result.success) {
        debugPrint('Saved Fingerprints Saved Successfully');
        await DBHiveService.clearSavedFingerprints();
        return;
      } else {
        debugPrint('Failed to Save Fingerprints $result');
      }
    } catch (e, t) {
      debugPrint('Error uploading Fingerprints to Server in online mood $e $t');
    }
  }

  // Add multiple fingerprints
  static Future<OperationResult<Map<String, dynamic>>> _addFingerprints({
    required BuildContext context,
    required List<Map<String, dynamic>> fingerprints,
  }) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.fingerprint).url;
    final requestBody = {'fingerprints': fingerprints};
    return await DioApiService().post<Map<String, dynamic>>(
      url,
      requestBody,
      context: context,
      dataKey: 'data',
      allData: true,
    );
  }

  // Add a QR code fingerprint with form data
  static Future<OperationResult<Map<String, dynamic>>> addQRCodeFingerprint({
    required BuildContext context,
    required String data,
    DateTime? fingerDay,
    required List<FilePickerResult> files,
  }) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.fingerprint).url;
    final formData = {
      'type': 'fp_scan',
      'data': data,
      'finger_day': '2024-08-11 16:00',
    };
    if (await ConnectionsService.isOnline() == true) {
      return await DioApiService().postWithFormData<Map<String, dynamic>>(
        url,
        context: context,
        formData,
        dataKey: 'data',
        files: files,
        allData: true,
      );
    } else {
      //OFFLINE CASE:SAVE FINGERPRINT TO LOCAL DB
      return await DBHiveService.saveFingerprint(formData)
          .then((_) => OperationResult<Map<String, dynamic>>(
              success: true,
              message: 'Fingerprint Saved successfully in Locale Storage'))
          .catchError((err, t) => OperationResult<Map<String, dynamic>>(
              success: false,
              message: 'Failed to save fingerprint in Locale Storage'));
    }
  }

  // Add a GPS fingerprint
  static Future<OperationResult<Map<String, dynamic>>> addGPSFingerprint({
    required BuildContext context,
    required String type,
    DateTime? fingerDay,
    required double lat,
    required double long,
    required List<FilePickerResult> files,
  }) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.fingerprint).url;
    final requestBody = {
      'type': 'fp_navigate',
      'data': '{"lat":${lat.toString()},"long":${long.toString()}}',
      'finger_day':
          DateFormat('yyyy-MM-dd HH:mm').format(fingerDay ?? DateTime.now()),
    };
    if (await ConnectionsService.isOnline() == true) {
      return await DioApiService().postWithFormData<Map<String, dynamic>>(
          url, requestBody,
          context: context, dataKey: 'data', allData: true, files: files);
    } else {
      //OFFLINE CASE:SAVE FINGERPRINT TO LOCAL DB
      return await DBHiveService.saveFingerprint(requestBody)
          .then((_) => OperationResult<Map<String, dynamic>>(
              success: true,
              message: 'Fingerprint Saved successfully in Locale Storage'))
          .catchError((err, t) => OperationResult<Map<String, dynamic>>(
              success: false,
              message: 'Failed to save fingerprint in Locale Storage'));
    }
  }

  // Add a custom GPS fingerprint
  static Future<OperationResult<Map<String, dynamic>>> addCustomGPSFingerprint({
    required BuildContext context,
    required String type,
    required Map<String, dynamic> data,
    DateTime? fingerDay,
    required List<FilePickerResult> files,
    required double lat,
    required double long,
  }) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.fingerprint).url;
    final formData = {
      'type': 'custom_fp_navigate',
      'data': '{"lat":${lat.toString()},"long":${long.toString()}}',
      'finger_day':
          DateFormat('yyyy-MM-dd HH:mm').format(fingerDay ?? DateTime.now()),
    };
    if (await ConnectionsService.isOnline() == true) {
      return await DioApiService().postWithFormData<Map<String, dynamic>>(
        url,
        context: context,
        formData,
        dataKey: 'data',
        files: files,
        allData: true,
      );
    } else {
      //OFFLINE CASE:SAVE FINGERPRINT TO LOCAL DB
      return await DBHiveService.saveFingerprint(formData)
          .then((_) => OperationResult<Map<String, dynamic>>(
              success: true,
              message: 'Fingerprint Saved successfully in Locale Storage'))
          .catchError((err, t) => OperationResult<Map<String, dynamic>>(
              success: false,
              message: 'Failed to save fingerprint in Locale Storage'));
    }
  }

  // Add a Bluetooth fingerprint
  static Future<OperationResult<Map<String, dynamic>>> addBluetoothFingerprint(
      {required BuildContext context,
      required String data,
      DateTime? fingerDay,
      required List<FilePickerResult> files}) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.fingerprint).url;
    final requestBody = {
      'type': 'fp_bluetooth',
      'data': data,
      'finger_day':
          DateFormat('yyyy-MM-dd HH:mm').format(fingerDay ?? DateTime.now()),
    };
    if (await ConnectionsService.isOnline() == true) {
      return await DioApiService().postWithFormData<Map<String, dynamic>>(
          url, requestBody,
          context: context, dataKey: 'data', allData: true, files: files);
    } else {
      //OFFLINE CASE:SAVE FINGERPRINT TO LOCAL DB
      return await DBHiveService.saveFingerprint(requestBody)
          .then((_) => OperationResult<Map<String, dynamic>>(
              success: true,
              message: 'Fingerprint Saved successfully in Locale Storage'))
          .catchError((err, t) => OperationResult<Map<String, dynamic>>(
              success: false,
              message: 'Failed to save fingerprint in Locale Storage'));
    }
  }

  // Add a wifi fingerprint
  static Future<OperationResult<Map<String, dynamic>>> addWifiFingerprint(
      {required BuildContext context,
      required String data,
      DateTime? fingerDay,
      required List<FilePickerResult> files}) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.fingerprint).url;
    final requestBody = {
      'type': 'fp_wifi',
      'data': data,
      'finger_day':
          DateFormat('yyyy-MM-dd HH:mm').format(fingerDay ?? DateTime.now()),
    };
    if (await ConnectionsService.isOnline() == true) {
      return await DioApiService().postWithFormData<Map<String, dynamic>>(
          url, requestBody,
          context: context, dataKey: 'data', allData: true, files: files);
    } else {
      //OFFLINE CASE:SAVE FINGERPRINT TO LOCAL DB
      return await DBHiveService.saveFingerprint(requestBody)
          .then((_) => OperationResult<Map<String, dynamic>>(
              success: true,
              message: 'Fingerprint Saved successfully in Locale Storage'))
          .catchError((err, t) => OperationResult<Map<String, dynamic>>(
              success: false,
              message: 'Failed to save fingerprint in Locale Storage'));
    }
  }

  // Add a NFC fingerprint
  static Future<OperationResult<Map<String, dynamic>>> addNFCFingerprint(
      {required BuildContext context,
      required String data,
      DateTime? fingerDay,
      required List<FilePickerResult> files}) async {
    final url = EndpointServices.getApiEndpoint(EndpointsNames.fingerprint).url;
    final requestBody = {
      'type': 'fp_nfc',
      'data': data,
      'finger_day':
          DateFormat('yyyy-MM-dd HH:mm').format(fingerDay ?? DateTime.now()),
    };
    if (await ConnectionsService.isOnline() == true) {
      return await DioApiService().postWithFormData<Map<String, dynamic>>(
          url, requestBody,
          context: context, dataKey: 'data', allData: true, files: files);
    } else {
      //OFFLINE CASE:SAVE FINGERPRINT TO LOCAL DB
      return await DBHiveService.saveFingerprint(requestBody)
          .then((_) => OperationResult<Map<String, dynamic>>(
              success: true,
              message: 'Fingerprint Saved successfully in Locale Storage'))
          .catchError((err, t) => OperationResult<Map<String, dynamic>>(
              success: false,
              message: 'Failed to save fingerprint in Locale Storage'));
    }
  }
}
