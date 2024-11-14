import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/models/settings/user_settings.model.dart';
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

  List<FeatureItem>? getAllOnboardingData({required BuildContext context}) {
    // return (AppSettingsService.getSettings(
    //         settingsType: SettingsType.generalSettings,
    //         context: context) as GeneralSettingsModel)
    //     .features
    //     ?.items;
    return defaultGeneralSettings.features?.items;
  }

  FeatureItem? getOnboardingDataWithIndex(int index, BuildContext context) {
    final items = getAllOnboardingData(context: context);
    if (items != null && index >= 0 && index < items.length) {
      return items[index];
    }
    return null;
  }

  var userSettings;
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

      await AppSettingsService.initializeGeneralSettings(
          settingType: SettingsType.startupSettings, context: context);
      userSettings = await AppSettingsService.getSettings(
          settingsType: SettingsType.userSettings,
          context: context) as UserSettingsModel;
      print("UserSettingsModel----- > ${userSettings.name}");
    } catch (e) {
      debugPrint('Error initializing app services: $e');
    }
  }

  Future<void> initializeSplashScreen(
      {required BuildContext context, role}) async {
    final appConfigService =
        Provider.of<AppConfigService>(context, listen: false);
    try {
      if (await ConnectionsService.isOnline()) {
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
          if(role != null){
            if(role!.contains('Customer') ){
              context.goNamed(AppRoutes.eCommerceHomeScreen.name,
                  pathParameters: {'lang': context.locale.languageCode});
            } else if(role!.contains('Merchant') || role!.contains('traders')|| role!.contains('admin')){
              context.goNamed(AppRoutes.merchantHomeScreen.name,
                  pathParameters: {'lang': context.locale.languageCode});
            }else if(role!.contains('Painter')){
              context.goNamed(AppRoutes.painterHomeScreen.name,
                  pathParameters: {'lang': context.locale.languageCode});
            }else{
              context.goNamed(AppRoutes.merchantHomeScreen.name,
                  pathParameters: {'lang': context.locale.languageCode});
            }
          }
          return;
        } else {
          final features = getAllOnboardingData(context: context);
          if (features == null || features.isEmpty) {
            context.goNamed(AppRoutes.login.name,
                pathParameters: {'lang': context.locale.languageCode});
            return;
          } else {
            await _precacheImages(context, features);
            context.goNamed(AppRoutes.onboarding.name,
                pathParameters: {'lang': context.locale.languageCode});
            return;
          }
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
      BuildContext context, List<FeatureItem> features) async {
    for (var item in features) {
      final image = item.image;
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
      context.goNamed(AppRoutes.login.name,
          pathParameters: {'lang': context.locale.languageCode});
    }
  }

  void skip(BuildContext context) => context.goNamed(AppRoutes.login.name,
      pathParameters: {'lang': context.locale.languageCode});

  // void skip(BuildContext context) => context.goNamed(AppRoutes.stores.name,
  //     pathParameters: {'lang': context.locale.languageCode});
}
