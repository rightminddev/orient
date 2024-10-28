import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/general_services/layout.service.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_elevated_button.widget.dart';
import '../../../common_modules_widgets/language_dropdown_button.widget.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../view_models/splash_onboarding.viewmodel.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingViewModel>(
      create: (context) => OnboardingViewModel(),
      child: Scaffold(
        body: Consumer<OnboardingViewModel>(
          builder: (context, viewModel, child) {
            return Stack(
              children: [
                PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: viewModel.pageController,
                    onPageChanged: (index) => viewModel.currentIndex = index,
                    itemCount: viewModel
                        .getAllOnboardingData(context: context)
                        ?.length,
                    itemBuilder: (context, index) {
                      final image = viewModel
                          .getOnboardingDataWithIndex(index, context)
                          ?.image;
                      if (image?.startsWith('http') == true ||
                          image?.startsWith('https') == true) {
                        // Network image
                        return CachedNetworkImage(
                          imageUrl: image!,
                          fit: BoxFit.cover,
                          key: ValueKey<String>(image),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                      } else {
                        // Asset image
                        return Image.asset(
                          image!,
                          fit: BoxFit.cover,
                          key: ValueKey<String>(image),
                        );
                      }
                    }),
                // Logo
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  left: AppSizes.s0,
                  right: AppSizes.s0,
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.s20),
                    width: LayoutService.getWidth(context),
                    height: AppSizes.s125,
                    child: Center(
                      child: Image.asset(
                        AppImages.logo,
                        fit: BoxFit.fill,
                        key: const ValueKey<String>(AppImages.logo),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: AppSizes.s48,
                  left: AppSizes.s0,
                  right: AppSizes.s0,
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppSizes.s16),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.s25),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.s18, vertical: AppSizes.s20),
                      height: AppSizes.s300,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: PageView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: viewModel.pageController2,
                              itemCount: viewModel
                                  .getAllOnboardingData(context: context)
                                  ?.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      viewModel
                                              .getOnboardingDataWithIndex(
                                                  index, context)
                                              ?.title ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(height: 1.2),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    gapH20,
                                    AutoSizeText(
                                      viewModel
                                              .getOnboardingDataWithIndex(
                                                  index, context)
                                              ?.info ??
                                          "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(height: 1.4),
                                      textAlign: TextAlign.center,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomElevatedButton(
                                    onPressed: () async =>
                                        viewModel.goNext(context),
                                    title: AppStrings.next.tr(),
                                    //  width: AppSizes.s150,
                                    isPrimaryBackground: true,
                                    isFuture: false),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  onPressed: () => viewModel.skip(context),
                                  // style: ElevatedButton.styleFrom(
                                  //   fixedSize:
                                  //       const Size(AppSizes.s150, AppSizes.s50),
                                  // ),
                                  child: Text(AppStrings.skip.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const LanguageDropdownButton()
              ],
            );
          },
        ),
      ),
    );
  }
}
