
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/modules/home/view_models/user_cont.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              type: settingsType, data: defaultGeneralSettings.toJson(),
          dataS1: defaultUserSettings.toJson(),
            dataS2: defaultUserSettings2.toJson()
          );
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
        bool closeDate = false,
        bool? allData = false,
        required BuildContext context}) async {
    final appConfigServiceProvider =
    Provider.of<AppConfigService>(context, listen: false);
    var settingsData = appConfigServiceProvider.getSettings(type: settingType);
    var lastUpdateDate = settingsData?.lastUpdateDate ?? "";
    OperationResult<Map<String, dynamic>> result;
    var s1Cache;
    var s2Cache;
    var gCache;
    if (settingType == SettingsType.startupSettings) {
      Map<String, dynamic> body = {
        if(CacheHelper.getString("gDate")!= null )"last_update_date_general": CacheHelper.getString("gDate"),
       if (CacheHelper.getString("s1Date")!= null && closeDate == false)"last_update_date_user": CacheHelper.getString("s1Date"),
        if (CacheHelper.getString("s2Date") != null && closeDate == false) "last_update_date_user2": CacheHelper.getString("s2Date"),
        "needed": [
          "general_settings",
          "user_settings",
          "user2_settings",
          "check_auth"
        ],
        if(appConfigServiceProvider.token.isNotEmpty) "token": appConfigServiceProvider.token,
        "device_id": appConfigServiceProvider.deviceInformation.deviceUniqueId
      };
      result = await DioApiService().post<Map<String, dynamic>>(
          EndpointServices.getApiEndpoint(EndpointsNames.startApp).url.trim(),
          body,
          context: context,
          dataKey: 'general_settings',
          allData: allData);
    }
    else {
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
      if(result.data!['user_settings'] != null &&
          result.data!['user_settings']['status']  != false &&
          CacheHelper.getString("US1") != null && CacheHelper.getString("US1") != ""){CacheHelper.deleteData(key: "US1");}
      if(result.data!['user2_settings'] != null &&
          result.data!['user2_settings'] ['status']  != false  &&
          CacheHelper.getString("US2") != null &&
          CacheHelper.getString("US2") != ""){
        CacheHelper.deleteData(key: "US2").then((v){
          print("DELETED FROM CACHE SUCCESS");
        });}
      if(result.data!['general_settings'] != null &&result.data!['general_settings'] ['status']  != false && CacheHelper.getString("USG") != null && CacheHelper.getString("USG") != ""){CacheHelper.deleteData(key: "USG");}
      var prefs = await SharedPreferences.getInstance();
     if(result.data!['user_settings'] != null){
       if (result.data!['user_settings']['data'] != null){
         CacheHelper.setString(key: "s1Date", value: result.data!['user_settings']['data']['last_update_date']);
         prefs = await SharedPreferences.getInstance();
         final jsonString = json.encode(result.data!['user_settings']['data']); // Convert JSON to String
         await prefs.setString("US1", jsonString);
       }
     }
     if (result.data!['general_settings']['data'] != null){
       CacheHelper.setString(key: "gDate", value: result.data!['general_settings']['data']['last_update_date']);
        prefs = await SharedPreferences.getInstance();
       final jsonString = json.encode(result.data!['general_settings']['data']); // Convert JSON to String
       await prefs.setString("USG", jsonString);
     }
     if(result.data!['user2_settings'] != null){
       if (result.data!['user2_settings']['data'] != null){
         CacheHelper.setString(key: "s2Date", value: result.data!['user2_settings']['data']['last_update_date']);
         prefs = await SharedPreferences.getInstance();
         final jsonString = json.encode(result.data!['user2_settings']['data']); // Convert JSON to String
         await prefs.setString("US2", jsonString);
       }
     }
      print("settingType is $settingType");
     if(result.data!['user_settings'] != null){
       if(CacheHelper.getString("US1") != null && result.data!['user_settings']['status'] == false){
         print("US1 FETCHING");
         final prefs = await SharedPreferences.getInstance();
         final jsonString = prefs.getString("US1");
         if (jsonString != null) {
           s1Cache = json.decode(jsonString) as Map<String, dynamic>; // Convert String back to JSON
           print("S1 IS --> $s1Cache");
         }
       }
     }
     if(result.data!['user2_settings'] != null){
       if(CacheHelper.getString("US2") != null&& result.data!['user2_settings']['status'] == false){
         print("US2 FETCHING");
         final prefs = await SharedPreferences.getInstance();
         final jsonString = prefs.getString("US2");
         if (jsonString != null) {
           s2Cache = json.decode(jsonString) as Map<String, dynamic>;// Convert String back to JSON
           print("S2 IS --> $s2Cache");
         }
       }
     }
      appConfigServiceProvider.setSettings(
          type: settingType,
          data:(result.data!['general_settings']['status'] == false)?gCache: result.data!['general_settings']['data'],
      dataS1: (result.data!['user_settings'] != null)?(result.data!['user_settings']['status'] == false)? s1Cache: result.data!['user_settings']['data'] : null,
        dataS2: (result.data!['user2_settings'] != null)?(result.data!['user2_settings']['status'] == false)? s2Cache : result.data!['user2_settings']['data'] : null
      );
    } else {
      // if error happened , then check if i have cached version of settings or not , if i have cached version i will use it , if not , i will store the default settings version into local storage.
      if (appConfigServiceProvider.getSettings(type: settingType) == null) {
        appConfigServiceProvider.setSettings(
            type: settingType,
            data: getSettings(settingsType: settingType, context: context)?.toJson(),
            dataS1: getSettings(settingsType: settingType, context: context)?.toJson(),
            dataS2: getSettings(settingsType: settingType, context: context)?.toJson(),
        );
      }
    }
  }

  /// used to get user_settings and user_settings_2
  static Future<void> getUserSettingsAndUpdateTheStoredSettings(
      {required BuildContext context, bool? allData = false, bool closeDate = false}) async {
    await initializeGeneralSettings(
        settingType: SettingsType.startupSettings,
        allData: allData,
        closeDate: closeDate,
        context: context);
    // await initializeGeneralSettings(
    //     settingType: SettingsType.user2Settings,
    //     allData: allData,
    //     context: context);
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
