import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:orient/general_services/app_config.service.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/dio.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:provider/provider.dart';

class LangControllerProvider extends ChangeNotifier{
  bool isLoading = false;
  bool isSuccess = true;
  String? errorMessage;
  setDeviceSysLang({context, state, notiToken}) async {
    final appConfigServiceProvider = Provider.of<AppConfigService>(context, listen: false);
    isLoading = true;
    notifyListeners();
    try {
      final response = await DioHelper.postData(
        url: "/rm_users/v1/device_sys",
        context: context,
        data: {
          "action": "set",
          "key": "language",
          "value": state,
          "default" : state,
          "device_info" : {
            "device_unique_id":appConfigServiceProvider.deviceInformation.deviceUniqueId,
            "operating_system":"android",
            "operating_system_version":"QSR1.190920.001",
            "type":"phone",
            "notification_token":notiToken}
        },
      );
      isLoading = false;
      isSuccess = true;
      CacheHelper.setString(key: "lang", value: state);
      print(response.data);
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
      if (error is DioError) {
        errorMessage = error.response?.data['message'] ?? 'Something went wrong';
      } else {
        errorMessage = error.toString();
      }
    }
  }
}