import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/layout.service.dart';
import 'package:orient/merchant/main/view_models/merchant_main_view_model.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
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
  void initState() {
    super.initState();
    homeViewModel = HomeViewModel();
    langControllerProvider = LangControllerProvider();
    merchantMainViewModel = MerchantMainViewModel();
    merchantMainViewModel.selectIndexs = 0;
    viewModel = OnboardingViewModel();
    initializeHomeAndSplash();
  }

  Future<void> initializeHomeAndSplash() async {
      await homeViewModel.initializeHomeScreen(context);
      if(LocalizationService.isArabic(context: context)){
        await langControllerProvider.setDeviceSysLang(
            state:  "ar",
            context: context,
            notiToken:await FirebaseMessaging.instance.getToken()
        );
      }else{
        await langControllerProvider.setDeviceSysLang(
            state:  "en",
            context: context,
            notiToken:await FirebaseMessaging.instance.getToken()
        );
      }
    if(homeViewModel.userSettings != null){
      print("Model is -> ${homeViewModel.userSettings!.name}");
    }
    viewModel.initializeSplashScreen(
      context: context,
        role: (homeViewModel.userSettings != null)? homeViewModel.userSettings!.role : null
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
