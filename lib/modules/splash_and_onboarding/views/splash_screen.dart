import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/layout.service.dart';
import 'package:orient/modules/home/view_models/home.viewmodel.dart';
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
  @override
  void initState() {
    super.initState();
    homeViewModel = HomeViewModel();
    viewModel = OnboardingViewModel();
    initializeHomeAndSplash();
  }

  Future<void> initializeHomeAndSplash() async {
    await homeViewModel.initializeHomeScreen(context);
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
