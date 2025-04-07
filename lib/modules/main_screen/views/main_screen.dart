import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/app_theme.service.dart';
import '../../../routing/app_router.dart';
import '../view_models/main_viewmodel.dart';
import 'widgets/custom_bottom_nav_item.widget.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  final NavbarPages currentNavPage;
  const MainScreen(
      {super.key, required this.child, required this.currentNavPage});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainScreenViewModel>(context);
    viewModel.currentPage = currentNavPage;
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
                  isSelected: currentNavPage == NavbarPages.home,
                  onTap: () => viewModel.onItemTapped(
                      context: context, page: NavbarPages.home),
                ),
                BottomNavItem(
                  icon: AppImages.requestsBottomBarIcon,
                  label: AppStrings.requests.tr(),
                  isSelected: currentNavPage == NavbarPages.requests,
                  onTap: () => viewModel.onItemTapped(
                      context: context, page: NavbarPages.requests),
                ),
                BottomNavItem(
                  icon: AppImages.fingerprintBottomBarIcon,
                  label: AppStrings.fingerprint.tr(),
                  isSelected: currentNavPage == NavbarPages.fingerprint,
                  onTap: () => viewModel.onItemTapped(
                      context: context, page: NavbarPages.fingerprint),
                ),
                BottomNavItem(
                  icon: AppImages.notificationBottomBarIcon,
                  label: AppStrings.notifications.tr(),
                  isSelected: currentNavPage == NavbarPages.notifications,
                  onTap: () => viewModel.onItemTapped(
                      context: context, page: NavbarPages.notifications),
                ),
                BottomNavItem(
                  icon: AppImages.moreBottomBarIcon,
                  label: AppStrings.more.tr(),
                  isSelected: currentNavPage == NavbarPages.more,
                  onTap: () => viewModel.onItemTapped(
                      context: context, page: NavbarPages.more),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
