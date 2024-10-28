import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import '../../models/operation_result.model.dart';
import '../app_config.service.dart';
import 'api_service/dio_api_service/dio_api.service.dart';
import 'backend_services_interface.dart';

abstract class ApiServiceHelpers {
  static Map<String, String> buildHeaders(
      {Map<String, dynamic>? additionalHeaders,
      bool? addToken = true,
      required BuildContext context}) {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'device-unique-id':
          appConfigServiceProvider.deviceInformation.deviceUniqueId
    };
    if (additionalHeaders != null && additionalHeaders.isNotEmpty) {
      for (var h in additionalHeaders.keys) {
        headers[h] = additionalHeaders[h]!;
      }
    }
    if ((addToken == true) && appConfigServiceProvider.token.isNotEmpty) {
      headers['authorization'] = 'Bearer ${appConfigServiceProvider.token}';
    }
    return headers;
  }

  /// custom Encoder for DateTime issue
  static dynamic customEncode(dynamic item) {
    if (item is DateTime) {
      return intl.DateFormat("yyyy-MM-ddTHH:mm:ss").format(item);
    }
    return item;
  }

  static OperationResult<T> parseResponse<T>(
      {required Map responseJsonData,
      required String dataKey,
      bool? allData = false}) {
    return OperationResult(
      success: responseJsonData['status'] is bool
          ? responseJsonData['status']
          : responseJsonData['status']?.toString() == "true",
      message: responseJsonData['message'] is Map ||
              responseJsonData['message'] == null
          ? (responseJsonData['messageAr'] ??
              responseJsonData['errorString'] ??
              responseJsonData['fullMessagesString'] ??
              responseJsonData['errorCodeString'] ??
              'No Server Error!')
          : responseJsonData['message'],
      data: allData == true ? responseJsonData : responseJsonData[dataKey],
      checkAuth: responseJsonData['check_auth'],
      errorCodeString: responseJsonData['errorCodeString']?.toString(),
    );
  }

  static Future<OperationResult> getRefreshTokens(
      {required String dataKey, required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    if (appConfigServiceProvider.refreshTokenApiUrl == null ||
        (appConfigServiceProvider.refreshTokenApiUrl?.isEmpty ?? true)) {
      return OperationResult(
          success: false, message: "refreshTokenApiURL is null or empty");
    }
    OperationResult result = await DioApiService.getDynamic(
        appConfigServiceProvider.refreshTokenApiUrl!, context,
        dataKey: dataKey, checkOnTokenExpiration: false);
    if (result.success) {
      return result;
    } else {
      return OperationResult(success: false, message: result.message);
    }
  }

  static bool isTokenExpired({required BuildContext context}) {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    if (appConfigServiceProvider.checkValueExist("accessTokenExpDate")) {
      if (DateTime.fromMillisecondsSinceEpoch(
              appConfigServiceProvider.accessTokenExpDate * 1000)
          .isAfter(DateTime.now().subtract(const Duration(hours: 3)))) {
        return true;
      }
      return false;
    }
    return false;
  }

  static Future<bool> assignNewTokens({required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    try {
      if (!isTokenExpired(context: context)) return true;
      if (appConfigServiceProvider.checkValueExist("refreshTokenExpDate")) {
        DateTime dateTimeFromMilliseconds = DateTime.fromMillisecondsSinceEpoch(
            appConfigServiceProvider.accessTokenExpDate * 1000);
        DateTime now = DateTime.now();
        // if (dateTimeFromMilliseconds.isBefore(now)) {
        //   debugPrint(
        //       '-------> access Expire Date is before current time by ${now.difference(dateTimeFromMilliseconds).inSeconds.toString()}');
        // } else if (dateTimeFromMilliseconds.isAfter(now)) {
        //   debugPrint(
        //       '-------> access Expire Date is after current time by ${dateTimeFromMilliseconds.difference(now).inSeconds.toString()}');
        // } else {
        //   debugPrint('-------> access Expire Date is equal to current time');
        // }
        //checks if refresh token is still valid
        if (dateTimeFromMilliseconds.isBefore(now)) {
          debugPrint("-----> overrides access token with refresh token");
          //overrides access token with refresh token
          await appConfigServiceProvider
              .setToken(appConfigServiceProvider.refreshToken);
          OperationResult response =
              await getRefreshTokens(dataKey: 'refreshToken', context: context);
          if (response.success) {
            await appConfigServiceProvider.setToken(response.data['token']);
            appConfigServiceProvider.refreshToken =
                response.data['refreshToken'];
            appConfigServiceProvider.accessTokenExpDate =
                response.data['tokenExp'];
            appConfigServiceProvider.refreshTokenExpDate =
                response.data['refreshTokenExp'];
            return true;
          } else {
            return false;
          }
        }
      }
      return true;
    } catch (ex) {
      return false;
    }
  }

  static Future<OperationResult<T>> checkExpirationOfTokens<T>(
      {required bool checkOnTokenExpiration,
      required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    // checks if token is expired
    if (appConfigServiceProvider.checkOnTokenExpiration == true) {
      if (checkOnTokenExpiration == true) {
        if (appConfigServiceProvider.token.isNotEmpty &&
            appConfigServiceProvider.refreshToken.isNotEmpty) {
          bool isRefreshedSuccessfully =
              await ApiServiceHelpers.assignNewTokens(context: context);

          if (isRefreshedSuccessfully != true) {
            //call unauthorized callback and return OperationResult with false result
            if (BackEndServicesInterface.unauthrizedCallback != null) {
              BackEndServicesInterface.unauthrizedCallback?.call(401);
            }

            return OperationResult<T>(
                success: false, message: 'Refresh token is not valid');
          }
        }
      }
    }
    return OperationResult<T>(success: true, message: 'Token is valid');
  }
}
