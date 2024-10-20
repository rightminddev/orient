import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../constants/settings/default_general_settings.dart';
import '../constants/settings/default_user_settings.dart';
import '../constants/settings/default_user_settings_2.dart';
import '../models/endpoint.model.dart';
import '../models/operation_result.model.dart';
import '../models/settings/app_settings_model.dart';
import '../models/settings/general_settings.model.dart';
import 'app_config.service.dart';
import 'backend_services/api_service/dio_api_service/dio_api.service.dart';
import 'backend_services/get_endpoint.service.dart';

enum SettingsType {
  generalSettings,
  userSettings,
  user2Settings,
  startupSettings
}

abstract class AppSettingsService {
  /// this method for usage in entire app to get any kind of settings [generalSettings] || [userSettings] || [userSettings2]
  static AppSettingsModel? getSettings(
      {required SettingsType settingsType, required BuildContext context}) {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    switch (settingsType) {
      case SettingsType.generalSettings:
      case SettingsType.startupSettings:
        final generalSettings =
            appConfigServiceProvider.getSettings(type: settingsType);
        if (generalSettings == null) {
          appConfigServiceProvider.setSettings(
              type: settingsType, data: defaultGeneralSettings.toJson());
          return defaultGeneralSettings;
        }
        return generalSettings;

      case SettingsType.userSettings:
        final userSettings =
            appConfigServiceProvider.getSettings(type: settingsType);
        if (userSettings == null) {
          appConfigServiceProvider.setSettings(
              type: settingsType, data: defaultUserSettings.toJson());
          return defaultUserSettings;
        }
        return userSettings;

      case SettingsType.user2Settings:
        final user2Settings =
            appConfigServiceProvider.getSettings(type: settingsType);
        if (user2Settings == null) {
          appConfigServiceProvider.setSettings(
              type: settingsType, data: defaultUserSettings2.toJson());
          return defaultUserSettings2;
        }
        return user2Settings;

      default:
        return null;
    }
  }

  /// method to initialize the general settings and check if there is updates or not.
  /// setting type [general_settings] || [user_settings] || [user2_settings]
  static Future<void> initializeGeneralSettings(
      {required SettingsType settingType,
      bool? allData = false,
      required BuildContext context}) async {
    final appConfigServiceProvider =
        Provider.of<AppConfigService>(context, listen: false);
    var settingsData = appConfigServiceProvider.getSettings(type: settingType);
    var lastUpdateDate = settingsData?.lastUpdateDate ?? "";
    OperationResult<Map<String, dynamic>> result;
    if (settingType == SettingsType.startupSettings) {
      Map<String, dynamic> body = {
        "last_update_date": lastUpdateDate,
        "needed": [
          "general_settings",
          "user_settings",
          "user2_settings",
          "check_auth"
        ],
        // "token": AppConfigService.token,
        "device_id": appConfigServiceProvider.deviceInformation.deviceUniqueId
      };
      result = await DioApiService().post<Map<String, dynamic>>(
          EndpointServices.getApiEndpoint(EndpointsNames.startApp).url.trim(),
          body,
          context: context,
          dataKey: 'general_settings',
          allData: allData);
    } else {
      String settingTypeName = settingType == SettingsType.userSettings
          ? 'user_settings'
          : 'user2_settings';
      Map<String, dynamic> body = {
        "type": settingTypeName,
        "last_update_date": lastUpdateDate
      };
      result = await DioApiService().post<Map<String, dynamic>>(
          EndpointServices.getApiEndpoint(EndpointsNames.userSettings)
              .url
              .trim(),
          body,
          context: context,
          dataKey: 'user_settings',
          allData: allData);
    }
    if (result.success &&
        result.data != null &&
        (result.data?.isNotEmpty ?? false)) {
      // Update Stored Setting with the new settings
      appConfigServiceProvider.setSettings(
          type: settingType, data: result.data?['data']);
    } else {
      // if error happened , then check if i have cached version of settings or not , if i have cached version i will use it , if not , i will store the default settings version into local storage.
      if (appConfigServiceProvider.getSettings(type: settingType) == null) {
        appConfigServiceProvider.setSettings(
            type: settingType,
            data: getSettings(settingsType: settingType, context: context)
                ?.toJson());
      }
    }
  }

  /// used to get user_settings and user_settings_2
  static Future<void> getUserSettingsAndUpdateTheStoredSettings(
      {required BuildContext context, bool? allData = false}) async {
    await initializeGeneralSettings(
        settingType: SettingsType.userSettings,
        allData: allData,
        context: context);
    await initializeGeneralSettings(
        settingType: SettingsType.user2Settings,
        allData: allData,
        context: context);
  }

  /// used to get screen general message [NOTE] page route will be used as screen id.
  static String? getGeneralScreenMessageByScreenId(
      {required String screenId, required BuildContext context}) {
    List<GeneralMessageByScreen>? list = (getSettings(
            settingsType: SettingsType.generalSettings,
            context: context) as GeneralSettingsModel)
        .generalMessageByScreen;
    if (list == null || list.isEmpty) return null;
    for (var element in list) {
      if (element.screenId == screenId) {
        return element.screenMessage;
      }
    }
    return null;
  }

  /// used to get request title
  static String? getRequestTitleFromGenenralSettings(
      {String? requestId, required BuildContext context}) {
    GeneralSettingsModel? generalSettings = getSettings(
        settingsType: SettingsType.generalSettings,
        context: context) as GeneralSettingsModel;
    if (generalSettings.requestTypes?.keys.contains(requestId) ?? false) {
      return generalSettings.requestTypes?[requestId]?.requestType?.title;
    }
    return null;
  }
}
