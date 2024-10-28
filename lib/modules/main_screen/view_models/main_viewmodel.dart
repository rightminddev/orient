import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../routing/app_router.dart';
import '../../fingerprint/views/fingerprint_screen.dart';
import '../../home/views/home_screen.dart';
import '../../more/views/more_screen.dart';
import '../../notifications/views/notifications_screen.dart';
import '../../requests/views/requests_screen.dart';

class MainScreenViewModel extends ChangeNotifier {
  NavbarPages currentPage = NavbarPages.home;
  int get pageIndex => NavbarPages.values.indexOf(currentPage);

  void initializeMainScreen({
    required BuildContext context,
    required Type currentScreen,
  }) {
    switch (currentScreen) {
      case HomeScreen _:
        currentPage = NavbarPages.home;
        return;
      case RequestsScreen _:
        currentPage = NavbarPages.requests;
        return;
      case FingerprintScreen _:
        currentPage = NavbarPages.fingerprint;
        return;
      case NotificationsScreen _:
        currentPage = NavbarPages.notifications;
        return;
      case MoreScreen _:
        currentPage = NavbarPages.notifications;
        return;
      default:
        currentPage = NavbarPages.home;
        return;
    }
  }

  Widget getCurrentMainPage(NavbarPages currPage) {
    switch (currPage) {
      case NavbarPages.home:
        return const HomeScreen();
      case NavbarPages.fingerprint:
        return const FingerprintScreen();
      case NavbarPages.requests:
        return const RequestsScreen();
      case NavbarPages.notifications:
        return const NotificationsScreen();
      case NavbarPages.more:
        return const MoreScreen();
      default:
        return const HomeScreen();
    }
  }

  Future<void> onItemTapped(
      {required BuildContext context, required NavbarPages page}) async {
    if (page == currentPage) return;
    int oldIndex = pageIndex;
    int newIndex = NavbarPages.values.indexOf(page);
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
    required NavbarPages page,
    required Offset begin,
  }) async {
    switch (page) {
      case NavbarPages.home:
        await context.pushNamed(AppRoutes.home.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case NavbarPages.fingerprint:
        await context.pushNamed(AppRoutes.fingerprint.name,
            extra: {'offset': begin},
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case NavbarPages.requests:
        await context.pushNamed(AppRoutes.requests.name,
            extra: begin,
            pathParameters: {
              'type': 'mine',
              'lang': context.locale.languageCode
            });
        return;
      case NavbarPages.notifications:
        await context.pushNamed(AppRoutes.notifications.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case NavbarPages.more:
        await context.pushNamed(AppRoutes.more.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;

      default:
        await context.pushNamed(AppRoutes.home.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
    }
  }
}
