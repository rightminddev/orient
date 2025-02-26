import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/backend_services/api_service/dio_api_service/shared.dart';
import 'package:orient/general_services/layout.service.dart';
import 'package:orient/merchant/main/view_models/merchant_main_view_model.dart';
import 'package:orient/models/settings/user_settings.model.dart';
import 'package:orient/models/settings/user_settings_2.model.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
import 'package:orient/modules/home/view_models/user_cont.dart';
import 'package:orient/modules/shared_more_screen/lang_setting/logic/lang_controller.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/localization.service.dart';
import '../../../utils/overlay_gradient_widget.dart';
import '../view_models/splash_onboarding.viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final OnboardingViewModel viewModel;
  late final HomeViewModel homeViewModel;
  late final MerchantMainViewModel merchantMainViewModel;
  late final LangControllerProvider langControllerProvider;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Now it's safe to use EasyLocalization
      bool isArabic = LocalizationService.isArabic(context: context);
      bool isEnglish = LocalizationService.isArabic(context: context);
      if(isArabic == true){CacheHelper.setString(key: "lang", value: "ar");}
      if(isArabic == false){CacheHelper.setString(key: "lang", value: "en");}
      // Use `isArabic` to control any logic based on language
    });
    homeViewModel = HomeViewModel();
    priting();
    langControllerProvider = LangControllerProvider();
    merchantMainViewModel = MerchantMainViewModel();
    viewModel = OnboardingViewModel();
    merchantMainViewModel.selectIndexs = 0;
    initializeHomeAndSplash();
    //playTest();
  }
  priting(){
    print("MODEL IS --> ${UserSettingConst.userSettings}");
  }
  playTest()async{
    print("PLAY IS IN PROCESS");
    const url = "store?category=electronics";
    final result = await viewModel.analyzeRoute(url);
    if (result != null) {
      print("Route Key: ${result['key']}");
      print("Parameters: ${result['values']}");
    } else {
      print("No matching route found.");
    }
  }
  Future<void> initializeHomeAndSplash() async {
      print("INITIAL11");
      await homeViewModel.initializeHomeScreen(context);

    final jsonString = CacheHelper.getString("US1");
    final json2String = CacheHelper.getString("US2");
    var us1Cache;
    var us2Cache;
    if (jsonString != null && jsonString != "") {
      us1Cache = json.decode(jsonString) as Map<String, dynamic>;// Convert String back to JSON
      CacheHelper.setString(key: "roles", value: us1Cache['role']);
      print("S1 IS --> $us1Cache");
    }
    if (json2String != null && json2String != "") {
      us2Cache = json.decode(json2String) as Map<String, dynamic>;// Convert String back to JSON
      print("S2 IS --> $us2Cache");
    }
    print("MODEL IS --> ${UserSettingConst.userSettings}");
    if(UserSettingConst.userSettings != null){
      print("Model is -> ${UserSettingConst.userSettings!.role}");
    }
    if (us1Cache != null && us1Cache.isNotEmpty && us1Cache != "") {
      try {
        // Decode JSON string into a Map
        // Convert the Map to the appropriate type (e.g., UserSettingsModel)
        UserSettingConst.userSettings = UserSettingsModel.fromJson(us1Cache);
      } catch (e) {
        print("Error decoding user settings: $e");
      }
    }
    else {
      print("us1Cache is null or empty.");
    }
    if (us2Cache != null && us2Cache.isNotEmpty && us2Cache != "") {
      try {
        // Decode JSON string into a Map
        // Convert the Map to the appropriate type (e.g., UserSettingsModel)
        UserSettingConst.userSettings2 = UserSettings2Model.fromJson(us2Cache);
      } catch (e) {
        print("Error decoding user settings: $e");
      }
    }
    else {
      print("us2Cache is null or empty.");
    }
    print("AMr ${CacheHelper.getString("roles")}");
    print(UserSettingConst.userSettings!.role);
    print(us1Cache);
    viewModel.initializeSplashScreen(
      context: context,
        role: (UserSettingConst.userSettings != null)? UserSettingConst.userSettings!.role : CacheHelper.getString("roles")
    );
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingViewModel>(
      create: (context) => viewModel,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppImages.splashScreenBackground,
                fit: BoxFit.cover,
                key: const ValueKey<String>(AppImages.splashScreenBackground)),
            const OverlayGradientWidget(),
            Positioned(
              left: AppSizes.s0,
              right: AppSizes.s0,
              child: SizedBox(
                height: LayoutService.getHeight(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox.shrink(),
                    Image.asset(
                      AppImages.logo,
                      height: AppSizes.s100,
                      width: LayoutService.getWidth(context) - AppSizes.s50,
                      key: const ValueKey<String>(AppImages.logo),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.s40),
                      child: Text(
                        AppStrings.loading.tr(),
                        style: LocalizationService.isArabic(context: context)
                            ? Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(letterSpacing: 0)
                            : Theme.of(context).textTheme.displayMedium,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
