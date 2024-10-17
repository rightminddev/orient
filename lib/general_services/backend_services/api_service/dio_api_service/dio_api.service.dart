import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

import '../../../../models/operation_result.model.dart';
import '../../../app_config.service.dart';
import '../../api_service_helpers.dart';
import '../../backend_services_interface.dart';

class DioApiService implements BackEndServicesInterface {
  static final DioApiService _singleton = DioApiService._internal();
  factory DioApiService() {
    return _singleton;
  }
  DioApiService._internal();

  static Future<OperationResult<T>> _handleResponse<T>(
      {required Response response,
      required bool applyTokenLogic,
      required String dataKey,
      required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    String? respond;
    switch (response.statusCode) {
      case 200:
        String reply = response.data;
        if (reply.isEmpty) {
          return OperationResult<T>(success: false, message: 'Result is empty');
        }
        var json = jsonDecode(reply);
        if (applyTokenLogic) {
          // if new token founded in the incoming response, then update the current token with the new one
          try {
            if (T is Map) {
              var newToken =
                  (json['data'] as Map<String, dynamic>)['token'] as String?;
              if (newToken != null && newToken.isNotEmpty) {
                await appConfigServiceProvider.setToken(newToken);
              }
            }
          } catch (err, t) {
            debugPrint(
                '--------- Failed while updating current token from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
          }
        }
        return ApiServiceHelpers.parseResponse<T>(
            responseJsonData: json, dataKey: dataKey);

      case 400:
        respond = 'Bad Request';
        // _toast.toastMethod(LocaleKeys.respond_400.tr());
        return OperationResult<T>(success: false, message: respond);

      case 401:
        respond = 'Unauthorized';
        // _toast.toastMethod(LocaleKeys.respond_401.tr());
        // Applying logic that triggers while unauthorized responses
        return OperationResult<T>(success: false, message: respond);

      case 429:
        respond = 'Too Many Requests';
        // _toast.toastMethod(LocaleKeys.respond_429.tr());
        return OperationResult<T>(success: false, message: respond);

      case 404:
        respond = 'Not Found';
        // _toast.toastMethod(LocaleKeys.respond_404.tr());
        return OperationResult<T>(success: false, message: respond);

      case 500:
        respond = 'Server Error';
        // _toast.toastMethod(LocaleKeys.respond_500.tr());
        return OperationResult<T>(success: false, message: respond);

      default:
        respond = 'Unknown Error';
        return OperationResult<T>(
            success: false, message: 'Result code = ${response.statusCode}');
    }
  }

  @override
  Future<OperationResult<T>> get<T>(String url,
      {required String dataKey,
      Map<String, String>? header,
      bool? checkOnTokenExpiration = true,
      required BuildContext context}) async {
    try {
      final response = await Dio().get(
        url,
        options: Options(
            headers: ApiServiceHelpers.buildHeaders(
                additionalHeaders: header, context: context)),
      );
      return await _handleResponse<T>(
          response: response,
          applyTokenLogic: checkOnTokenExpiration!,
          dataKey: dataKey,
          context: context);
    } catch (err, t) {
      debugPrint(
          '--------- Failed get() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
      return OperationResult(success: false, message: err.toString());
    }
  }

  @override
  Future<OperationResult<T>> post<T>(
    String url,
    dynamic data, {
    required String dataKey,
    required BuildContext context,
    Map<String, String>? header,
    bool? checkOnTokenExpiration = true,
  }) async {
    try {
      final response = await Dio().post(
        url,
        data: jsonEncode(data),
        options: Options(
            headers: ApiServiceHelpers.buildHeaders(
                additionalHeaders: header, context: context)),
      );
      return _handleResponse(
          response: response,
          applyTokenLogic: checkOnTokenExpiration!,
          dataKey: dataKey,
          context: context);
    } catch (err, t) {
      debugPrint(
          '--------- Failed post() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
      return OperationResult(success: false, message: err.toString());
    }
  }

  @override
  Future<OperationResult<T>> postWithFormData<T>(
    String url,
    Map<String, String> data, {
    required String dataKey,
    required List<FilePickerResult> files,
    Map<String, String>? header,
    bool? checkOnTokenExpiration = true,
    required BuildContext context,
  }) async {
    try {
      var formData = FormData.fromMap(data);

      for (var file in files) {
        for (var fileItem in file.files) {
          String mimeType =
              lookupMimeType(fileItem.name) ?? 'application/octet-stream';
          formData.files.add(MapEntry(
            'files', // The field name for the file parameter
            MultipartFile.fromBytes(
              fileItem.bytes!,
              filename: fileItem.name,
              contentType: MediaType.parse(mimeType),
            ),
          ));
        }
      }

      final response = await Dio().post(
        url,
        data: formData,
        options: Options(
          headers: ApiServiceHelpers.buildHeaders(
              additionalHeaders: header, context: context),
        ),
      );

      if (response.statusCode == 200) {
        var json = response.data;
        return ApiServiceHelpers.parseResponse<T>(
          responseJsonData: json,
          dataKey: dataKey,
        );
      } else {
        return OperationResult<T>(
          success: false,
          message: 'Result code = ${response.statusCode}',
        );
      }
    } catch (err, t) {
      debugPrint(
          'Failed postWithFormData() ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
      return OperationResult<T>(
        success: false,
        message: err.toString(),
      );
    }
  }

  @override
  Future<OperationResult<T>> put<T>(String url, Map data,
      {required String dataKey,
      required BuildContext context,
      Map<String, String>? header,
      bool? checkOnTokenExpiration = true}) async {
    try {
      final response = await Dio().put(
        url,
        data: jsonEncode(data),
        options: Options(
            headers: ApiServiceHelpers.buildHeaders(
                additionalHeaders: header, context: context)),
      );
      return _handleResponse(
          response: response,
          applyTokenLogic: checkOnTokenExpiration!,
          context: context,
          dataKey: dataKey);
    } catch (err, t) {
      debugPrint(
          '--------- Failed put() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
      return OperationResult(success: false, message: err.toString());
    }
  }

  @override
  Future<OperationResult<T>> delete<T>(String url, Map data,
      {required String dataKey,
      Map<String, String>? header,
      required BuildContext context,
      bool? checkOnTokenExpiration = true}) async {
    try {
      final response = await Dio().delete(
        url,
        data: jsonEncode(data),
        options: Options(
            headers: ApiServiceHelpers.buildHeaders(
                additionalHeaders: header, context: context)),
      );
      return _handleResponse(
          response: response,
          applyTokenLogic: checkOnTokenExpiration!,
          dataKey: dataKey,
          context: context);
    } catch (err, t) {
      debugPrint(
          '--------- Failed delete() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
      return OperationResult(success: false, message: err.toString());
    }
  }

  @override
  Future<OperationResult<T>> postFile<T>(
    String url,
    Uint8List fileData,
    String name, {
    required String dataKey,
    Map<String, String>? requestFields,
    Map<String, String>? header,
    required BuildContext context,
    bool isImage = true,
  }) async {
    try {
      String mimeType = lookupMimeType(name) ?? 'application/octet-stream';
      String fileName = name.split('/').last;

      FormData formData = FormData.fromMap({
        ...requestFields ?? {},
        'file': MultipartFile.fromBytes(
          fileData,
          filename: fileName,
          contentType: MediaType.parse(mimeType),
        ),
      });

      final response = await Dio().post(
        url,
        data: formData,
        options: Options(
            headers: ApiServiceHelpers.buildHeaders(
                additionalHeaders: header, context: context)),
      );

      if (response.statusCode == 200) {
        var json = response.data;
        return ApiServiceHelpers.parseResponse<T>(
            responseJsonData: json, dataKey: dataKey);
      } else {
        return OperationResult<T>(
          success: false,
          message: 'Result code = ${response.statusCode}',
        );
      }
    } catch (err, t) {
      debugPrint(
          'Failed postFileWithDio() ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
      return OperationResult<T>(
        success: false,
        message: err.toString(),
      );
    }
  }

  @override
  Future<OperationResult<T>> patch<T>(String url, Map data,
      {required String dataKey,
      Map<String, String>? header,
      bool checkOnTokenExpiration = true,
      required BuildContext context}) async {
    try {
      final response = await Dio().patch(
        url,
        data: jsonEncode(data),
        options: Options(
            headers: ApiServiceHelpers.buildHeaders(
                additionalHeaders: header, context: context)),
      );
      return _handleResponse(
          response: response,
          applyTokenLogic: checkOnTokenExpiration,
          context: context,
          dataKey: dataKey);
    } catch (err, t) {
      debugPrint(
          '--------- Failed put() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
      return OperationResult(success: false, message: err.toString());
    }
  }
}
