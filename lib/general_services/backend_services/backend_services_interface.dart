import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/operation_result.model.dart';

abstract class BackEndServicesInterface {
  static Function(dynamic response)? unauthrizedCallback;

  Future<OperationResult<T>> get<T>(String url,
      {required String dataKey,
      Map<String, String>? header,
      bool checkOnTokenExpiration = true,
      required BuildContext context});

  Future<OperationResult<T>> post<T>(String url, dynamic data,
      {required String dataKey,
      Map<String, String>? header,
      bool checkOnTokenExpiration = true,
      required BuildContext context});

  Future<OperationResult<T>> postWithFormData<T>(
    String url,
    Map<String, String> data, {
    required String dataKey,
    required List<FilePickerResult> files,
    Map<String, String>? header,
    bool checkOnTokenExpiration = true,
    required BuildContext context,
  });

  Future<OperationResult<T>> put<T>(String url, Map data,
      {required String dataKey,
      Map<String, String>? header,
      bool checkOnTokenExpiration = true,
      required BuildContext context});
  Future<OperationResult<T>> patch<T>(String url, Map data,
      {required String dataKey,
      Map<String, String>? header,
      bool checkOnTokenExpiration = true,
      required BuildContext context});
  Future<OperationResult<T>> delete<T>(String url, Map data,
      {required String dataKey,
      Map<String, String>? header,
      bool checkOnTokenExpiration = true,
      required BuildContext context});

  Future<OperationResult<T>> postFile<T>(
      String url, Uint8List fileData, String name,
      {required String dataKey,
      Map<String, String>? requestFields,
      Map<String, String>? header,
      required BuildContext context,
      bool isImage = true});
}
