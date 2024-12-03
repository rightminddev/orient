import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/modules/eCommerce_more_screen.dart';
import 'package:orient/modules/ecommerce/cart/cart_screen.dart';
import 'package:orient/modules/ecommerce/home/home_screen.dart';
import 'package:orient/modules/ecommerce/myorder/ecommerce_order_screen.dart';
import 'package:orient/modules/ecommerce/search/search_screen.dart';
import 'package:orient/modules/ecommerce/test_screen.dart';
import 'package:orient/modules/settings_page/settings_page.dart';
import '../../../routing/app_router.dart';
import '../../home/views/home_screen.dart';


class EcommerceMainScreenViewModel extends ChangeNotifier {
  EcommerceNavbarPages currentPage = EcommerceNavbarPages.eCommerceHomeScreen;
  int get pageIndex => EcommerceNavbarPages.values.indexOf(currentPage);
  List<String> navs = [
    "assets/images/ecommerce/svg/nav1.svg",
    "assets/images/ecommerce/svg/nav2.svg",
    "assets/images/ecommerce/svg/nav3.svg",
    "assets/images/ecommerce/svg/nav4.svg",
    "assets/images/ecommerce/svg/nav5.svg",
  ];
  int? selectIndexs = 0;
  void initializeMainScreen({
    required BuildContext context,
    required Type currentScreen,
  }) {
    switch (currentScreen) {
      case ECommerceHomeScreen _:
        currentPage = EcommerceNavbarPages.eCommerceHomeScreen;
        return;
      case TestScreen _:
        currentPage = EcommerceNavbarPages.ecommerceTestScreen;
        return;
      case EcommerceOrderScreen _:
        currentPage = EcommerceNavbarPages.eCommerceMyOrderScreen;
        return;
      case ECommerceSearchScreen _:
        currentPage = EcommerceNavbarPages.eCommerceSearchScreen;
        return;
      case SettingsPage _:
        currentPage = EcommerceNavbarPages.eCommerceMoreScreen;
        return;
      default:
        currentPage = EcommerceNavbarPages.eCommerceHomeScreen;
        return;
    }
  }

  Widget getCurrentMainPage(EcommerceNavbarPages currPage) {
    switch (currPage) {
      case EcommerceNavbarPages.eCommerceHomeScreen:
        return  ECommerceHomeScreen();
      case EcommerceNavbarPages.ecommerceTestScreen:
        return const TestScreen();
      case EcommerceNavbarPages.eCommerceMyOrderScreen:
        return const EcommerceOrderScreen();
      case EcommerceNavbarPages.eCommerceSearchScreen:
        return  ECommerceSearchScreen(viewArrow: false,);
      case EcommerceNavbarPages.eCommerceMoreScreen:
        return SettingsPage();
      default:
        return const HomeScreen();
    }
  }

  Future<void> onItemTapped(
      {required BuildContext context, required EcommerceNavbarPages page}) async {
    if (page == currentPage) return;
    int oldIndex = pageIndex;
    int newIndex = EcommerceNavbarPages.values.indexOf(page);
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
    required EcommerceNavbarPages page,
    required Offset begin,
  }) async {
    switch (page) {
      case EcommerceNavbarPages.eCommerceHomeScreen:
         context.pushReplacementNamed(AppRoutes.eCommerceHomeScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case EcommerceNavbarPages.ecommerceTestScreen:
         context.pushReplacementNamed(AppRoutes.eCommerceTestScreen.name,
            extra: {'offset': begin},
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case EcommerceNavbarPages.eCommerceMyOrderScreen:
         context.pushReplacementNamed(AppRoutes.eCommerceMyOrderScreen.name,
            extra: begin,
            pathParameters: {
              'lang': context.locale.languageCode
            });
        return;
      case EcommerceNavbarPages.eCommerceSearchScreen:
        await context.pushNamed(AppRoutes.eCommerceSearchScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case EcommerceNavbarPages.eCommerceMoreScreen:
         context.pushReplacementNamed(AppRoutes.eCommerceMoreScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
      default:
         context.pushReplacementNamed(AppRoutes.eCommerceHomeScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
    }
  }
}
