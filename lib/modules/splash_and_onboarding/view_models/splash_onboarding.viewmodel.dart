import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/models/settings/user_settings.model.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_images.dart';
import '../../../constants/settings/default_general_settings.dart';
import '../../../general_services/app_config.service.dart';
import '../../../general_services/app_info.service.dart';
import '../../../general_services/backend_services/get_endpoint.service.dart';
import '../../../general_services/connections.service.dart';
import '../../../general_services/device_info.service.dart';
import '../../../general_services/notification_service/notification.service.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/endpoint.model.dart';
import '../../../models/settings/general_settings.model.dart';
import '../../../routing/app_router.dart';
import '../../../services/fingerprint_service.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  final PageController pageController2 = PageController();
  int _currentIndex = 0;

  set currentIndex(int newIndex) => _currentIndex = newIndex;
  @override
  void dispose() {
    pageController.dispose();
    pageController2.dispose();
    super.dispose();
  }

  List<FeatureItems>? getAllOnboardingData({required BuildContext context}) {
    final jsonString = CacheHelper.getString("USG");
    if (jsonString != null && jsonString.isNotEmpty) {
      print("jsonString is --> $jsonString");
      final gCache = json.decode(jsonString) as Map<String, dynamic>; // Convert String back to JSON
      print("S2 IS --> $gCache");

      if (gCache['features'] != null && gCache['features']['items'].isNotEmpty) {
        // Convert the List<dynamic> to List<FeatureItems>
        defaultGeneralSettings.features!.items = (gCache['features']['items'] as List<dynamic>)
            .map((item) => FeatureItems.fromJson(item))
            .toList();
      }
    }
    return defaultGeneralSettings.features!.items;
  }


  FeatureItems? getOnboardingDataWithIndex(int index, BuildContext context) {
    final items = getAllOnboardingData(context: context);
    if (items != null && index >= 0 && index < items.length) {
      return items[index];
    }
    return null;
  }

 // var userSettings;
  Future<void> _initializeAppServices(
      BuildContext context, AppConfigService appConfigService) async {
    try {
      // Precache logo image
      await precacheImage(const AssetImage(AppImages.logo), context);

      // Initialize application services
      await appConfigService.init();

      // Initialize and set device information in local storage
      DeviceInformationService.initializeAndSetDeviceInfo(context: context);

      // Set base API URL
      appConfigService.apiURL = AppConstants.baseUrl;

      // Optional: Enable or disable checking for token expiration
      appConfigService.checkOnTokenExpiration = false;

      // Optional: Set refresh token API URL
      appConfigService.refreshTokenApiUrl = AppConstants.refreshTokenBaseUrl;

      // Optional: Set application name
      appConfigService.appName =
          await ApplicationInformationService.getAppName();

      // Optional: Set application version
      appConfigService.appVersion =
          await ApplicationInformationService.getAppVersion();

      // Optional: Set application build number
      appConfigService.buildNumber =
          await ApplicationInformationService.getAppBuildNumber();

      // Optional: Set application package name
      appConfigService.packageName =
          await ApplicationInformationService.getAppPackageName();

      await ConnectionsService.init();

      // await AppSettingsService.initializeGeneralSettings(
      //     settingType: SettingsType.startupSettings, context: context);
      // userSettings = await AppSettingsService.getSettings(
      //     settingsType: SettingsType.userSettings,
      //     context: context) as UserSettingsModel;
      // print("UserSettingsModel----- > ${userSettings.name}");
    } catch (e) {
      debugPrint('Error initializing app services: $e');
    }
  }
  Future<List<dynamic>> loadJson() async {
    const filepath = 'assets/json/routes.json';
    final content = await rootBundle.loadString(filepath);
    return jsonDecode(content);
  }
  Future<Map<String, dynamic>?> analyzeRoute(String url) async {
    // Decode JSON into an array
    final allRoute = await loadJson();

    // Parse URL and extract path and query parameters
    final uri = Uri.parse(url);
    final path = uri.path.trim().replaceAll(RegExp(r'^/|/$'), ''); // Trim leading/trailing slashes
    final queryParams = uri.queryParameters;

    // Iterate through routes to find a match
    for (final route in allRoute) {
      final routePattern = route['route'];

      // Extract placeholder names (e.g., {id})
      final keys = RegExp(r'\{([^\}]+)\}')
          .allMatches(routePattern)
          .map((match) => match.group(1)!)
          .toList();

      // Convert route pattern to regex
      final pattern = '^' +
          routePattern.replaceAll(RegExp(r'\{[^\}]+\}'), '([^/]+)').replaceAll('/', r'\/') +
          r'$';

      // Check if the path matches the pattern
      final matches = RegExp(pattern).allMatches(path);
      if (matches.isNotEmpty) {
        final match = matches.first;
        final params = <String, String>{};

        for (var i = 0; i < keys.length; i++) {
          params[keys[i]] = match.group(i + 1)!;
        }

        // Add query parameters to the values
        params.addAll(queryParams);

        // Return the matching route key and parameters
        return {
          'key': route['key'],
          'values': params,
        };
      }
    }
    // Return null if no match is found
    return null;
  }
  Future<void> initializeSplashScreen(
      {required BuildContext context, role}) async {
    final appConfigService =
        Provider.of<AppConfigService>(context, listen: false);
    late final HomeViewModel homeViewModel;
    homeViewModel = HomeViewModel();
    try {
      if (await ConnectionsService.isOnline()) {
        //await homeViewModel.initializeHomeScreen(context);
        await _initializeAppServices(context, appConfigService);
        if (appConfigService.isLogin && appConfigService.token.isNotEmpty) {
          // initializing notification service
          //print("UserSettingsModel 2 ----- > ${userSettings.role[0]}");
          try {
            await PushNotificationService.init(
              context: context,
              apiUrlThatReciveUserToken:
                  EndpointServices.getApiEndpoint(EndpointsNames.deviceSys).url,
            );
          } catch (ex) {
            debugPrint(
                'Failed to send notification device token to server $ex');
          }
          // check if there are saved fingerprint to send it to the server
          try {
            await FingerprintService.uploadFingerprintsInOnlineMood(
                context: context);
          } catch (ex) {
            debugPrint('Failed to send saved fingerprints to server $ex');
          }
          final features = getAllOnboardingData(context: context);
          final jsonString = CacheHelper.getString("USG");
          var gCache;
          if (jsonString != null && jsonString != "") {
            gCache = json.decode(jsonString) as Map<String, dynamic>;// Convert String back to JSON
            print("S2 IS --> $gCache");
          }
          var dateToCheck = DateTime.parse(CacheHelper.getString("dateWatchScreen"));
          final referenceDate = DateTime.parse(gCache['features']['date']);
          print("IS THIS --> ${referenceDate.isAfter(dateToCheck)}");
          if (CacheHelper.getString("dateWatchScreen") == null || referenceDate.isAfter(dateToCheck)) {
            await _precacheImages(context, features!);
            context.goNamed(AppRoutes.onboarding.name,
                pathParameters: {'lang': context.locale.languageCode});
          } else {
            print("ROLE IS $role");
            if(role != null){
              if (role!.contains('admin')){
                context.goNamed(
                  AppRoutes.loginAdmin.name,
                  pathParameters: {'lang': context.locale.languageCode,  'fromSplash' : "false"},
                );
              } else if(role!.contains('customer')){
                context.goNamed(AppRoutes.eCommerceHomeScreen.name,
                    pathParameters: {'lang': context.locale.languageCode});
              } else if(role!.contains('merchant') || role!.contains('traders')){
                context.goNamed(AppRoutes.merchantHomeScreen.name,
                    pathParameters: {'lang': context.locale.languageCode});
              }else if(role!.contains('painter')){
                context.goNamed(AppRoutes.painterHomeScreen.name,
                    pathParameters: {'lang': context.locale.languageCode});
              }else{
                context.goNamed(AppRoutes.merchantHomeScreen.name,
                    pathParameters: {'lang': context.locale.languageCode});
              }
            }else {
              print("ROLE FROM CACHE IS ---> ${CacheHelper.getString('role')}");
              print("login1");
              context.goNamed(
                AppRoutes.loginAdmin.name,
                pathParameters: {'lang': context.locale.languageCode,  'fromSplash' : "true"},
              );
            }
          }
          return;
        } else {
          final features = getAllOnboardingData(context: context);
          final jsonString = CacheHelper.getString("USG");
          var gCache;
          var dateToCheck ;
          var referenceDate ;
          if (jsonString != null && jsonString != "") {
            gCache = json.decode(jsonString) as Map<String, dynamic>;// Convert String back to JSON
            print("S2 IS --> $gCache");
             referenceDate = DateTime.parse(gCache['features']['date']);
            print("Date IS --> $referenceDate");
          }
          if(CacheHelper.getString("dateWatchScreen") != null && CacheHelper.getString("dateWatchScreen") != ""){
            dateToCheck = DateTime.parse(CacheHelper.getString("dateWatchScreen"));
          }

          if (features == null || features.isEmpty) {
            print("login2");
            context.goNamed(
              AppRoutes.login.name,
              pathParameters: {'lang': context.locale.languageCode,
              },
            );
            return;
          } else {
            print("dateWatchScreen is --> ${CacheHelper.getString("dateWatchScreen")}");
            print(gCache);
           //print("IS THIS --> ${DateTime.parse(CacheHelper.getString("dateWatchScreen")).isAfter(DateTime.parse(gCache['features']['date']))}");
           // print("features is --> ${DateTime.parse(gCache['features']['date'])}");
            if (CacheHelper.getString("dateWatchScreen") == null ||CacheHelper.getString("dateWatchScreen") == "" ||
                gCache == null || gCache['features']['date'] == ""||dateToCheck.isAfter(referenceDate) == false ) {
              await _precacheImages(context, features);
              context.goNamed(AppRoutes.onboarding.name,
                  pathParameters: {'lang': context.locale.languageCode});
            } else {
              print("login3");
              context.goNamed(
                AppRoutes.loginAdmin.name,
                pathParameters: {'lang': context.locale.languageCode,  'fromSplash' : "true"},
              );
            }
          }
            return;
        }
      } else {
        context.goNamed(AppRoutes.offlineScreen.name,
            pathParameters: {'lang': context.locale.languageCode});
      }
    } catch (err, t) {
      debugPrint(
          "Error in initializing splash screen: ${err.toString()} - (${t.toString()})");
    }
  }

  Future<void> _precacheImages(
      BuildContext context, List<FeatureItems> features) async {
    for (var item in features) {
      final image = item.image![0].file;
      if (image != null) {
        try {
          if (image.startsWith('http') || image.startsWith('https')) {
            // Network image
            await precacheImage(CachedNetworkImageProvider(image), context);
          } else {
            // Asset image
            await precacheImage(AssetImage(image), context);
          }
        } catch (e) {
          debugPrint('Error precaching image ($image): $e');
        }
      }
    }
  }

  void goNext(BuildContext context) {
    const int duration = 500;
    final items = getAllOnboardingData(context: context);

    if (items != null && _currentIndex < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: duration),
        curve: Curves.easeInOut,
      );
      pageController2.nextPage(
        duration: const Duration(milliseconds: duration),
        curve: Curves.easeInOut,
      );
      currentIndex = _currentIndex + 1;
    } else {
      final appConfigService =
      Provider.of<AppConfigService>(context, listen: false);
      final jsonString = CacheHelper.getString("US1");
      var us1Cache;
      var role;
      if (jsonString != "") {
        us1Cache = json.decode(jsonString) as Map<String, dynamic>;// Convert String back to JSON
        print("S2 IS --> $us1Cache");
        role = us1Cache['role'];
      }
      if (appConfigService.isLogin && appConfigService.token.isNotEmpty){
        if(role != null){
          if (role!.contains('admin')){
            context.goNamed(
              AppRoutes.loginAdmin.name,
              pathParameters: {'lang': context.locale.languageCode,  'fromSplash' : "false"},
            );
          } else if(role!.contains('customer')){
            context.goNamed(AppRoutes.eCommerceHomeScreen.name,
                pathParameters: {'lang': context.locale.languageCode});
          } else if(role!.contains('merchant') || role!.contains('traders')){
            context.goNamed(AppRoutes.merchantHomeScreen.name,
                pathParameters: {'lang': context.locale.languageCode});
          }else if(role!.contains('painter')){
            context.goNamed(AppRoutes.painterHomeScreen.name,
                pathParameters: {'lang': context.locale.languageCode});
          }else{
            context.goNamed(AppRoutes.merchantHomeScreen.name,
                pathParameters: {'lang': context.locale.languageCode});
          }
        }else {
          print("login4");
          context.goNamed(AppRoutes.login.name,
              pathParameters: {'lang': context.locale.languageCode,
              });
        }
      }else{
        context.goNamed(
          AppRoutes.loginAdmin.name,
          pathParameters: {'lang': context.locale.languageCode,
            'fromSplash' : "true"
          },
        );}
    }
  }

  void skip(BuildContext context) {
    final appConfigService =
    Provider.of<AppConfigService>(context, listen: false);
    final jsonString = CacheHelper.getString("US1");
    var us1Cache;
    var role;
    if (jsonString != "") {
      us1Cache = json.decode(jsonString) as Map<String, dynamic>;// Convert String back to JSON
      print("S2 IS --> $us1Cache");
       role = us1Cache['role'];
    }
     if (appConfigService.isLogin && appConfigService.token.isNotEmpty){
       if(role != null){
         if (role!.contains('admin')){
           context.goNamed(
             AppRoutes.loginAdmin.name,
             pathParameters: {'lang': context.locale.languageCode,  'fromSplash' : "false"},
           );
         } else if(role!.contains('customer')){
           context.goNamed(AppRoutes.eCommerceHomeScreen.name,
               pathParameters: {'lang': context.locale.languageCode});
         } else if(role!.contains('merchant') || role!.contains('traders')){
           context.goNamed(AppRoutes.merchantHomeScreen.name,
               pathParameters: {'lang': context.locale.languageCode});
         }else if(role!.contains('painter')){
           context.goNamed(AppRoutes.painterHomeScreen.name,
               pathParameters: {'lang': context.locale.languageCode});
         }else{
           context.goNamed(AppRoutes.merchantHomeScreen.name,
               pathParameters: {'lang': context.locale.languageCode});
         }
       }else {
         print("login4");
         context.goNamed(AppRoutes.login.name,
             pathParameters: {'lang': context.locale.languageCode,
             });
       }
    }else{
    context.goNamed(
      AppRoutes.loginAdmin.name,
      pathParameters: {'lang': context.locale.languageCode,
        'fromSplash' : "true"
      },
    );}
  }

  // void skip(BuildContext context) => context.goNamed(AppRoutes.stores.name,
  //     pathParameters: {'lang': context.locale.languageCode});
}
