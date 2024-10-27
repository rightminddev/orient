import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/merchant/main/subviews/merchant_home_screen.dart';
import 'package:orient/merchant/main/subviews/merchant_stores_screen.dart';
import '../../../routing/app_router.dart';

class MerchantMainViewModel extends ChangeNotifier {
  MerchantNavbarPages currentPage = MerchantNavbarPages.merchantHomeScreen;
  int get pageIndex => MerchantNavbarPages.values.indexOf(currentPage);

  void initializeMainScreen({
    required BuildContext context,
    required Type currentScreen,
  }) {
    switch (currentScreen) {
      case MerchantHomeScreen _:
        currentPage = MerchantNavbarPages.merchantHomeScreen;
        return;
      case MerchantStoresScreen _:
        currentPage = MerchantNavbarPages.merchantStoresScreen;
        return;
      default:
        currentPage = MerchantNavbarPages.merchantHomeScreen;
        return;
    }
  }

  Widget getCurrentMainPage(MerchantNavbarPages currPage) {
    switch (currPage) {
      case MerchantNavbarPages.merchantHomeScreen:
        return const MerchantHomeScreen();
      case MerchantNavbarPages.merchantStoresScreen:
        return const MerchantStoresScreen();
      default:
        return const MerchantHomeScreen();
    }
  }

  Future<void> onItemTapped({
    required BuildContext context,
    required MerchantNavbarPages page,
  }) async {
    if (page == currentPage) return;
    int oldIndex = pageIndex;
    int newIndex = MerchantNavbarPages.values.indexOf(page);
    currentPage = page;
    Offset begin = (newIndex > oldIndex)
        ? const Offset(1.0, 0.0)
        : const Offset(-1.0, 0.0);
    notifyListeners();
    await _pushNamedToPage(context: context, page: page, begin: begin);
    return;
  }

  Future<void> _pushNamedToPage({
    required BuildContext context,
    required MerchantNavbarPages page,
    required Offset begin,
  }) async {
    switch (page) {
      case MerchantNavbarPages.merchantHomeScreen:
        context.pushReplacementNamed(AppRoutes.merchantHomeScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case MerchantNavbarPages.merchantStoresScreen:
        context.pushReplacementNamed(AppRoutes.merchantStoresScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;

      default:
        context.pushReplacementNamed(AppRoutes.merchantHomeScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
    }
  }
}