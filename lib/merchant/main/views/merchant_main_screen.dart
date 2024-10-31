import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/constants/app_sizes.dart';
import 'package:orient/constants/app_strings.dart';
import 'package:orient/modules/main_screen/views/widgets/custom_bottom_nav_item.widget.dart';
import 'package:orient/routing/app_router.dart';
import 'package:provider/provider.dart';
import '../../../general_services/app_theme.service.dart';
import '../view_models/merchant_main_view_model.dart';

//MerchantMainScreen
class MerchantMainScreen extends StatelessWidget {
  final MerchantNavbarPages navbarPages;
  final Widget child;

  const MerchantMainScreen({
    super.key,
    required this.navbarPages,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MerchantMainViewModel>(context);
    viewModel.currentPage = navbarPages;
    return Scaffold(
      backgroundColor: AppThemeService.colorPalette.bodyBackgroundColor.color,
      body: child,
      bottomNavigationBar: Container(
        color: AppThemeService.colorPalette.btmAppBarBackgroundColor.color,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppThemeService.colorPalette.btmAppBarBackgroundColor.color,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: AppSizes.s10,
                offset: const Offset(0, -2),
              ),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(AppSizes.s26),
                topLeft: Radius.circular(AppSizes.s26)),
          ),
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavItem(
                  icon: AppImages.homeBottomBarIcon,
                  label: AppStrings.home.tr(),
                  isSelected:
                      navbarPages == MerchantNavbarPages.merchantHomeScreen,
                  onTap: () => viewModel.onItemTapped(
                      context: context,
                      page: MerchantNavbarPages.merchantHomeScreen),
                ),
                BottomNavItem(
                  icon: AppImages.requestsBottomBarIcon,
                  label: AppStrings.requests.tr(),
                  isSelected:
                      navbarPages == MerchantNavbarPages.merchantStoresScreen,
                  onTap: () => viewModel.onItemTapped(
                      context: context,
                      page: MerchantNavbarPages.merchantStoresScreen),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
