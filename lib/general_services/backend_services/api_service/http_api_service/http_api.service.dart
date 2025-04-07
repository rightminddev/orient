// import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:mime/mime.dart';
// import 'package:path/path.dart' as path;
// import 'package:http_parser/http_parser.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import '../../../../models/operation_result.model.dart';
// import '../../../app_config.service.dart';
// import '../../api_service_helpers.dart';
// import '../../backend_services_interface.dart';

// class HttpApiService implements BackEndServicesInterface {
//   static final HttpApiService _singleton = HttpApiService._internal();
//   factory HttpApiService() {
//     return _singleton;
//   }
//   HttpApiService._internal();
//   static Uri _getUri(String url) {
//     return Uri.parse(url);
//   }

//   static Future<OperationResult<T>> _handleResponse<T>(
//       {required http.Response response,
//       required bool applyTokenLogic,
//       required String dataKey,
//       required BuildContext context,
//       bool? allData = false}) async {
//     String? respond;
//     final appConfigServiceProvider =
//         Provider.of<AppConfigService>(context, listen: false);

//     switch (response.statusCode) {
//       case 200:
//         String reply = response.body;
//         if (reply.isEmpty) {
//           return OperationResult<T>(success: false, message: 'Result is empty');
//         }
//         var json = jsonDecode(reply);
//         if (applyTokenLogic) {
//           // if new token founded in the incomming response , then update the current token with the new one
//           try {
//             if (T is Map) {
//               var newToken = (json as Map<String, dynamic>)['token'] as String?;
//               if (newToken != null && newToken.isNotEmpty) {
//                 await appConfigServiceProvider.setToken(newToken);
//               }
//             }
//           } catch (err, t) {
//             debugPrint(
//                 '--------- Failed while updating current token from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//           }
//         }
//         if (json is Map == false) {
//           return OperationResult<T>(
//               success: true, message: 'Get Data Successfully', data: json);
//         }
//         return ApiServiceHelpers.parseResponse<T>(
//             responseJsonData: json, dataKey: dataKey, allData: allData);

//       case 400:
//         respond = 'Bad Request';
//         // _toast.toastMethod(LocaleKeys.respond_400.tr());
//         return OperationResult<T>(success: false, message: respond);

//       case 401:
//         respond = 'Unauthorized';
//         // _toast.toastMethod(LocaleKeys.respond_401.tr());
//         return OperationResult<T>(success: false, message: respond);

//       case 429:
//         respond = 'Too Many Requests';
//         // _toast.toastMethod(LocaleKeys.respond_429.tr());
//         return OperationResult<T>(success: false, message: respond);

//       case 404:
//         respond = 'Not Found';
//         // _toast.toastMethod(LocaleKeys.respond_404.tr());
//         return OperationResult<T>(success: false, message: respond);

//       case 500:
//         respond = 'Server Error';
//         // _toast.toastMethod(LocaleKeys.respond_500.tr());
//         return OperationResult<T>(success: false, message: respond);

//       default:
//         respond = 'Unknown Error';
//         return OperationResult<T>(
//             success: false, message: 'Result code = ${response.statusCode}');
//     }
//   }

//   @override
//   Future<OperationResult<T>> get<T>(String url,
//       {required String dataKey,
//       bool? allData = false,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true,
//       required BuildContext context}) async {
//     try {
//       debugPrint('GET --------------------- $url');
//       final response = await http.get(
//         _getUri(url),
//         headers: ApiServiceHelpers.buildHeaders(
//             additionalHeaders: header, context: context),
//       );
//       return await _handleResponse<T>(
//           response: response,
//           applyTokenLogic: checkOnTokenExpiration!,
//           dataKey: dataKey,
//           allData: allData,
//           context: context);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed get() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   @override
//   Future<OperationResult<T>> post<T>(String url, dynamic data,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true,
//       bool? allData = false,
//       required BuildContext context}) async {
//     try {
//       var httpClient = http.Client();
//       final response = await httpClient.post(
//         _getUri(url),
//         headers: ApiServiceHelpers.buildHeaders(
//             additionalHeaders: header, context: context),
//         body: jsonEncode(data),
//       );
//       return _handleResponse(
//           response: response,
//           applyTokenLogic: checkOnTokenExpiration!,
//           dataKey: dataKey,
//           allData: allData,
//           context: context);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed post() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   @override
//   Future<OperationResult<T>> postWithFormData<T>(
//     String url,
//     Map<String, String> data, {
//     required String dataKey,
//     required List<FilePickerResult> files,
//     String? fileFieldName,
//     Map<String, String>? header,
//     bool? checkOnTokenExpiration = true,
//     required BuildContext context,
//     bool? allData = false,
//   }) async {
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         _getUri(url),
//       );
//       request.fields.addAll(data);
//       request.headers.addAll(ApiServiceHelpers.buildHeaders(
//           additionalHeaders: header, context: context));

//       if (files.isNotEmpty) {
//         for (var file in files) {
//           for (var fileItem in file.files) {
//             String mimeType =
//                 lookupMimeType(fileItem.name) ?? 'application/octet-stream';
//             request.files.add(http.MultipartFile.fromBytes(
//               fileFieldName ?? 'files', // The field name for the file parameter
//               fileItem.bytes!,
//               filename: fileItem.name,
//               contentType: MediaType.parse(mimeType),
//             ));
//           }
//         }
//       }

//       final response = await request.send();
//       final responseString = await response.stream.bytesToString();

//       if (response.statusCode == 200) {
//         var json = jsonDecode(responseString);
//         return ApiServiceHelpers.parseResponse<T>(
//             responseJsonData: json, dataKey: dataKey, allData: allData);
//       } else {
//         return OperationResult<T>(
//           success: false,
//           message: 'Result code = ${response.statusCode}',
//         );
//       }
//     } catch (err, t) {
//       debugPrint(
//           'Failed postWithFormData() ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult<T>(
//         success: false,
//         message: err.toString(),
//       );
//     }
//   }

//   @override
//   Future<OperationResult<T>> put<T>(String url, Map data,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true,
//       bool? allData = false,
//       required BuildContext context}) async {
//     try {
//       final response = await http.put(
//         _getUri(url),
//         headers: ApiServiceHelpers.buildHeaders(
//             additionalHeaders: header, context: context),
//         body: jsonEncode(data),
//       );
//       return _handleResponse(
//           response: response,
//           applyTokenLogic: checkOnTokenExpiration!,
//           dataKey: dataKey,
//           allData: allData,
//           context: context);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed put() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   @override
//   Future<OperationResult<T>> patch<T>(String url, Map? data,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true,
//       bool? allData = false,
//       required BuildContext context}) async {
//     try {
//       final response = await http.patch(
//         _getUri(url),
//         headers: ApiServiceHelpers.buildHeaders(
//             additionalHeaders: header, context: context),
//         body: jsonEncode(data),
//       );
//       return _handleResponse(
//           response: response,
//           applyTokenLogic: checkOnTokenExpiration!,
//           dataKey: dataKey,
//           allData: allData,
//           context: context);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed put() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   @override
//   Future<OperationResult<T>> delete<T>(String url, Map data,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true,
//       bool? allData = false,
//       required BuildContext context}) async {
//     try {
//       final response = await http.delete(
//         _getUri(url),
//         headers: ApiServiceHelpers.buildHeaders(
//             additionalHeaders: header, context: context),
//       );
//       return _handleResponse(
//           response: response,
//           applyTokenLogic: checkOnTokenExpiration!,
//           dataKey: dataKey,
//           allData: allData,
//           context: context);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed delete() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   @override
//   Future<OperationResult<T>> postFile<T>(
//       String url, Uint8List fileData, String name,
//       {required String dataKey,
//       Map<String, String>? requestFields,
//       Map<String, String>? header,
//       bool isImage = true,
//       required BuildContext context}) async {
//     try {
//       String mimeType = lookupMimeType(name) ?? 'application/octet-stream';
//       String fileName = name.split('/').last;

//       var request = http.MultipartRequest('POST', _getUri(url));
//       request.fields.addAll(requestFields ?? {});
//       request.files.add(http.MultipartFile.fromBytes(
//         'file',
//         fileData,
//         filename: fileName,
//         contentType: MediaType.parse(mimeType),
//       ));
//       request.headers.addAll(header ?? {});

//       final response = await request.send();
//       final responseString = await response.stream.bytesToString();
//       if (response.statusCode == 200) {
//         var json = jsonDecode(responseString);
//         return ApiServiceHelpers.parseResponse<T>(
//             responseJsonData: json, dataKey: dataKey);
//       } else {
//         return OperationResult<T>(
//           success: false,
//           message: 'Result code = ${response.statusCode}',
//         );
//       }
//     } catch (err, t) {
//       debugPrint(
//           'Failed postFileWithHttp() ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult<T>(
//         success: false,
//         message: err.toString(),
//       );
//     }
//   }

//   ////////////////////////////////////////////////////////////////
//   /// Additional Methods
//   ////////////////////////////////////////////////////////////////

//   /// call backend and return OperationResult with Map
//   static Future<OperationResult<T>> getEx<T>(String url,
//       {Map<String, String>? header,
//       bool? checkOnTokenExpiration = true,
//       required BuildContext context}) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens<T>(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       var result = await getString(url, context, header: header);
//       if (!result.success) {
//         return OperationResult(
//           success: false,
//           message: result.message,
//         );
//       }
//       var map = json.decode(result.data ?? '');
//       return OperationResult(success: true, data: map);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed get() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   /// call backend and return OperationResult with Map
//   static Future<OperationResult<T>> postEx<T>(String url, dynamic data,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool asString = false,
//       bool? checkOnTokenExpiration = true,
//       required BuildContext context}) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens<T>(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       var httpClient = http.Client();
//       debugPrint('POST: ${(_getUri(url)).toString()}');

//       if (asString) {
//         data = json
//             .encode(data, toEncodable: ApiServiceHelpers.customEncode)
//             .replaceAll('"', '\'');
//       }
//       var body = json.encode(data, toEncodable: ApiServiceHelpers.customEncode);

//       http.Response response = await httpClient.post(
//         _getUri(url),
//         headers: ApiServiceHelpers.buildHeaders(
//             additionalHeaders: header, context: context),
//         body: utf8.encode(body),
//       );
//       if (response.statusCode != 200) //&& response.statusCode !=307
//       {
//         return OperationResult(
//             success: false, message: 'Result code = ${response.statusCode}');
//       }
//       var r = jsonDecode(response.body);
//       httpClient.close();
//       return ApiServiceHelpers.parseResponse(
//           responseJsonData: r, dataKey: dataKey);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed post() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   /// call backend and return OperationResult with Map
//   static Future<OperationResult<T>> putEx<T>(String url, Map data,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true,
//       required BuildContext context}) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens<T>(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       var httpClient = http.Client();

//       debugPrint('PUT: ${(_getUri(url)).toString()}');

//       http.Response response = await httpClient.put(
//         _getUri(url),
//         headers: ApiServiceHelpers.buildHeaders(
//             additionalHeaders: header, context: context),
//         body: json.encode(data, toEncodable: ApiServiceHelpers.customEncode),
//       );

//       if (response.statusCode != 200) //&& response.statusCode !=307
//       {
//         return OperationResult(
//             success: false, message: 'Result code = ${response.statusCode}');
//       }

//       String reply = response.body;

//       httpClient.close();

//       var r = jsonDecode(reply);
//       return ApiServiceHelpers.parseResponse(
//           responseJsonData: r, dataKey: dataKey);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed put() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   /// call backend and post file like images
//   static Future<OperationResult<String>> postFileEx(
//       String url, Uint8List fileData, String name,
//       {required String dataKey,
//       Map<String, String>? requestFields,
//       Map<String, String>? header,
//       bool isImage = true,
//       bool? checkOnTokenExpiration = true,
//       required BuildContext context}) async {
//     final appConfigServiceProvider =
//         Provider.of<AppConfigService>(context, listen: false);
//     String dataString;
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens<String>(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       var request = http.MultipartRequest("POST", _getUri(url));
//       request.headers['Authorization'] =
//           'Bearer ${appConfigServiceProvider.token}';
//       // request.fields['user'] = 'someone@somewhere.com';
//       request.files.add(http.MultipartFile.fromBytes(
//         'file',
//         fileData,
//         filename: name,
//         contentType: isImage
//             ? MediaType("image", path.extension(name))
//             : MediaType('application', 'x-tar'),
//       ));
//       request.fields['name'] = name;
//       request.fields['path'] = 'img';

//       request.headers["Authorization"] =
//           "Bearer ${appConfigServiceProvider.token}";
//       // request.headers["Accept"] = vimeoUploadHeader;
//       request.headers["Content-Type"] = "image/jpg";
//       if (requestFields != null) {
//         request.fields.addAll(requestFields);
//       }
//       if (header != null) {
//         request.headers.addAll(header);
//       }
//       //request.headers["Content-Length"] = fileData.length.toString();
//       var response = await request.send();
//       if (response.statusCode == 200) {
//         var data = (await response.stream.toBytes());
//         if (kDebugMode) print(data.length);
//         dataString = utf8.decode(data);
//         var r = json.decode(dataString);
//         return OperationResult(
//           data: r['data'] is Map ? r['data']['url'] : r['data'],
//           success: r['status'] is bool
//               ? r['status']
//               : r['status']?.toString() == "true",
//           message: r['message'] is Map || r['message'] == null
//               ? (r['messageAr'] ??
//                   r['errorString'] ??
//                   r['fullMessagesString'] ??
//                   r['errorCodeString'] ??
//                   'No Server Error!')
//               : r['message'],
//           errorCodeString: r['errorCodeString']?.toString(),
//           checkAuth: r['check_auth'] is bool
//               ? r['check_auth']
//               : r['check_auth']?.toString() == "true",
//         );
//       }
//       return OperationResult(
//           success: false, message: 'Error HttpPosFile: ${response.statusCode}');
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed postFile() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   /// call backend and return OperationResult with Map
//   static Future<OperationResult<dynamic>> postEx1(
//       String url, dynamic data, String dataKey, BuildContext context,
//       [Map<String, String>? header,
//       bool addToken = true,
//       bool? checkOnTokenExpiration = true]) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       debugPrint('POST: ${(_getUri(url)).toString()}');
//       var httpClient = http.Client();
//       var result = await httpClient.post(_getUri(url),
//           body: json.encode(data, toEncodable: ApiServiceHelpers.customEncode),
//           headers: ApiServiceHelpers.buildHeaders(
//               addToken: addToken, additionalHeaders: header, context: context));
//       httpClient.close();
//       if (result.statusCode != 200) {
//         return OperationResult(
//             success: false, message: 'Result code = ${result.statusCode}');
//       }

//       String reply = result.body;
//       var r = jsonDecode(reply);

//       return ApiServiceHelpers.parseResponse(
//           responseJsonData: r, dataKey: dataKey);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed postEx() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   /// call backend and return OperationResult with Map
//   static Future<OperationResult<dynamic>> putEx1(
//       String url, dynamic data, BuildContext context,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true}) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       debugPrint('PUT: ${(_getUri(url)).toString()}');
//       var httpClient = http.Client();
//       var result = await httpClient.put(_getUri(url),
//           body: json.encode(data, toEncodable: ApiServiceHelpers.customEncode),
//           headers: ApiServiceHelpers.buildHeaders(
//               additionalHeaders: header, context: context));
//       httpClient.close();
//       if (result.statusCode != 200) //&& response.statusCode !=307
//       {
//         return OperationResult(
//             success: false, message: 'Result code = ${result.statusCode}');
//       }

//       String reply = result.body;

//       var r = jsonDecode(reply);
//       return ApiServiceHelpers.parseResponse(
//           responseJsonData: r, dataKey: dataKey);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed putEx() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   /// call backend and return OperationResult with Map
//   static Future<OperationResult<dynamic>> getDynamic(
//       String url, BuildContext context,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true}) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       debugPrint('GET --------------------- ${(_getUri(url)).toString()}');
//       var httpClient = http.Client();
//       var response = await httpClient.get(_getUri(url),
//           headers: ApiServiceHelpers.buildHeaders(
//               additionalHeaders: header, context: context));
//       httpClient.close();

//       if (response.statusCode != 200) {
//         if (response.statusCode == 401 &&
//             BackEndServicesInterface.unauthrizedCallback != null) {
//           BackEndServicesInterface.unauthrizedCallback
//               ?.call(response.statusCode);
//         }
//         return OperationResult(
//             success: false, message: 'Result code = ${response.statusCode}');
//       }
//       String reply = response.body;
//       if (reply.isEmpty) {
//         return OperationResult(success: false, message: 'Result is empty');
//       }
//       var r = jsonDecode(reply);
//       if (r['success'] != true) {
//         if (r['errorCodeString'] == 'InvalidAuthentication' &&
//             BackEndServicesInterface.unauthrizedCallback != null) {
//           BackEndServicesInterface.unauthrizedCallback?.call(r);
//         }
//       }
//       return ApiServiceHelpers.parseResponse(
//           responseJsonData: r, dataKey: dataKey);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed getDynamic() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   /// this is for getting lat and long for map display
//   static Future<OperationResult<dynamic>> getMapLatAndLong(
//       String url, BuildContext context,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true}) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       debugPrint('GET --------------------- ${(_getUri(url)).toString()}');
//       var httpClient = http.Client();
//       var response = await httpClient.get(_getUri(url),
//           headers: ApiServiceHelpers.buildHeaders(
//               additionalHeaders: header, context: context));
//       httpClient.close();
//       if (response.statusCode != 200) {
//         if (response.statusCode == 401 &&
//             BackEndServicesInterface.unauthrizedCallback != null) {
//           BackEndServicesInterface.unauthrizedCallback
//               ?.call(response.statusCode);
//         }
//         return OperationResult(
//             success: false, message: 'Result code = ${response.statusCode}');
//       }
//       String reply = response.body;
//       if (reply.isEmpty) {
//         return OperationResult(success: false, message: 'Result is empty');
//       }
//       return OperationResult(
//         success: true,
//         data: jsonDecode(reply),
//       );
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed getDynamic() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   /// call backend and return OperationResult with Map
//   static Future<OperationResult<dynamic>> deleteDynamic(
//       String url, BuildContext context,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true}) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       debugPrint('DELETE --------------------- ${(_getUri(url)).toString()}');
//       var httpClient = http.Client();
//       var response = await httpClient.delete(_getUri(url),
//           headers: ApiServiceHelpers.buildHeaders(
//               additionalHeaders: header, context: context));
//       httpClient.close();
//       if (response.statusCode != 200) {
//         return OperationResult(
//             success: false, message: 'Result code = ${response.statusCode}');
//       }

//       String reply = response.body;

//       if (reply.isEmpty) {
//         return OperationResult(success: false, message: 'Result is empty');
//       }

//       var r = jsonDecode(reply);

//       return ApiServiceHelpers.parseResponse(
//           responseJsonData: r, dataKey: dataKey);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed deleteDynamic() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');
//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   /// call backend and return OperationResult with Map
//   static Future<OperationResult<dynamic>> dynamicDeleteEx(
//       String url, BuildContext context,
//       {required String dataKey,
//       Map<String, String>? header,
//       bool? checkOnTokenExpiration = true}) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens(
//               context: context,
//               checkOnTokenExpiration: checkOnTokenExpiration!);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       debugPrint('DELETE --------------------- ${(_getUri(url)).toString()}');
//       var httpClient = http.Client();

//       http.Response response = await httpClient.delete(_getUri(url),
//           headers: ApiServiceHelpers.buildHeaders(
//               additionalHeaders: header, context: context));

//       if (response.statusCode != 200) {
//         return OperationResult(
//             success: false, message: 'Result code = ${response.statusCode}');
//       }

//       String reply = response.body;
//       httpClient.close();

//       if (reply.isEmpty) {
//         return OperationResult(success: false, message: 'Result is empty');
//       }
//       var r = jsonDecode(reply);
//       return ApiServiceHelpers.parseResponse(
//           responseJsonData: r, dataKey: dataKey);
//     } catch (err, t) {
//       debugPrint(
//           '--------- Failed deleteDynamicEx() from Api Service ❌ \n error ${err.toString()} - in Line :- ${t.toString()}');

//       return OperationResult(success: false, message: err.toString());
//     }
//   }

//   static Future<OperationResult<String>> getString(
//       String url, BuildContext context,
//       {Map<String, String>? header,
//       bool? checkOnTokenExpiration = true}) async {
//     try {
//       // first : refresh access token using refresh token
//       var validateTokensResult =
//           await ApiServiceHelpers.checkExpirationOfTokens<String>(
//               checkOnTokenExpiration: checkOnTokenExpiration!,
//               context: context);
//       if (validateTokensResult.success == false) {
//         return validateTokensResult;
//       }
//       var httpClient = http.Client();
//       var result = await httpClient.get(_getUri(url),
//           headers: ApiServiceHelpers.buildHeaders(
//               additionalHeaders: header, context: context));
//       httpClient.close();
//       if (result.statusCode == 200) {
//         return OperationResult(success: true, data: result.body);
//       } else {
//         return OperationResult(
//             success: false, message: 'Result code = ${result.statusCode}');
//       }
//     } catch (err, t) {
//       return OperationResult(
//           success: false, message: err.toString() + t.toString());
//     }
//   }
// }
