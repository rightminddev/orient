import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../general_services/app_theme.service.dart';
import '../../../modules/main_screen/views/widgets/custom_bottom_nav_item.widget.dart';
import '../../../routing/app_router.dart';
import '../subviews/home_view.dart';
import '../subviews/my_stores_view.dart';

class MerchantMainScreen extends StatefulWidget {
  final int? index;
  const MerchantMainScreen({super.key, this.index});

  @override
  State<MerchantMainScreen> createState() => _MerchantMainScreenState();
}

class _MerchantMainScreenState extends State<MerchantMainScreen> {
  late final ValueNotifier<int> selectedIndex;

  @override
  void initState() {
    selectedIndex = ValueNotifier<int>(widget.index ?? 0);
    super.initState();
  }

  @override
  void dispose() {
    selectedIndex.dispose();
    super.dispose();
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  List<Widget> widgetOptions = <Widget>[
    HomeView(),
    MyStoresView(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<MainScreenViewModel>(context);
    // viewModel.currentPage = widget.currentNavPage;
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor:
              AppThemeService.colorPalette.bodyBackgroundColor.color,
          body: widgetOptions.elementAt(value),
          bottomNavigationBar: Container(
            color: AppThemeService.colorPalette.btmAppBarBackgroundColor.color,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color:
                    AppThemeService.colorPalette.btmAppBarBackgroundColor.color,
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
                      isSelected: value == 0,
                      onTap: () => onItemTapped(0),
                    ),
                    BottomNavItem(
                      icon: AppImages.requestsBottomBarIcon,
                      label: AppStrings.requests.tr(),
                      isSelected: value == 1,
                      onTap: () => onItemTapped(1),
                    ),
                    BottomNavItem(
                      icon: AppImages.fingerprintBottomBarIcon,
                      label: AppStrings.fingerprint.tr(),
                      isSelected: value == 2,
                      onTap: () => onItemTapped(2),
                    ),
                    BottomNavItem(
                      icon: AppImages.notificationBottomBarIcon,
                      label: AppStrings.notifications.tr(),
                      isSelected: value == 3,
                      onTap: () => onItemTapped(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
