import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/modules/settings_page/setting_page_two.dart';
import 'package:orient/painter/group_page/groups_page.dart';
import 'package:orient/painter/points/points_screen.dart';
import '../../../routing/app_router.dart';
import '../../home_screen/views/painter_main_screen.dart';
import '../../teams/views/teams_screen.dart';

class PainterMainScreenViewModel extends ChangeNotifier {
  PainterNavbarPages currentPage = PainterNavbarPages.painterHomeScreen;
  int get pageIndex => PainterNavbarPages.values.indexOf(currentPage);
  List<String> navs = [
    AppImages.painterNav1,
    AppImages.painterNav2,
    AppImages.painterNav3,
    AppImages.painterNav4,
    AppImages.painterNav5,
  ];
  int? selectIndexs = 0;
  void initializeMainScreen({
    required BuildContext context,
    required Type currentScreen,
  }) {
    switch (currentScreen) {
      case HomeScreen _:
        currentPage = PainterNavbarPages.painterHomeScreen;
        return;
      case GroupsPage _:
        currentPage = PainterNavbarPages.painterMyGroupsScreen;
        return;
      case TeamsScreen _:
        currentPage = PainterNavbarPages.painterTeamsScreen;
        return;
      case PointsScreen _:
        currentPage = PainterNavbarPages.painterPointsScreen;
        return;
      case SettingsPageTwo _:
        currentPage = PainterNavbarPages.painterProfileScreen;
        return;
      default:
        currentPage = PainterNavbarPages.painterHomeScreen;
        return;
    }
  }

  Widget getCurrentMainPage(PainterNavbarPages currPage) {
    switch (currPage) {
      case PainterNavbarPages.painterHomeScreen:
        return HomeScreen();
      case PainterNavbarPages.painterMyGroupsScreen:
        return GroupsPage(viewArrow: false,);
      case PainterNavbarPages.painterTeamsScreen:
        return TeamsScreen();
      case PainterNavbarPages.painterPointsScreen:
        return  PointsScreen(arrow: false,);
      case PainterNavbarPages.painterProfileScreen:
        return SettingsPageTwo();
      default:
        return  HomeScreen();
    }
  }

  Future<void> onItemTapped({
    required BuildContext context,
    required PainterNavbarPages page,
  }) async {
    if (page == currentPage) return;
    int oldIndex = PainterNavbarPages.values.indexOf(currentPage);
    int newIndex = PainterNavbarPages.values.indexOf(page);
    currentPage = page;
    Offset begin = (newIndex > oldIndex)
        ? const Offset(1.0, 0.0)
        : const Offset(-1.0, 0.0);
    notifyListeners();
    await _pushNamedToPage(context: context, page: page, begin: begin);
  }
  void onNavItemTapped(int index, context) {
    final page = PainterNavbarPages.values[index];

    if (page != currentPage) {
      onItemTapped(
        context: context,
        page: page,
      );
    }
  }

  Future<void> _pushNamedToPage({
    required BuildContext context,
    required PainterNavbarPages page,
    required Offset begin,
  }) async {
    switch (page) {
      case PainterNavbarPages.painterHomeScreen:
        context.pushReplacementNamed(AppRoutes.painterHomeScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case PainterNavbarPages.painterTeamsScreen:
        context.pushReplacementNamed(AppRoutes.painterTeamsScreen.name,
            extra: {'offset': begin},
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case PainterNavbarPages.painterMyGroupsScreen:
        context.pushReplacementNamed(AppRoutes.painterMyGroupsScreen.name,
            extra: begin,
            pathParameters: {
              'lang': context.locale.languageCode
            });
        return;
      case PainterNavbarPages.painterProfileScreen:
        await context.pushNamed(AppRoutes.painterProfileScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
      case PainterNavbarPages.painterPointsScreen:
        context.pushReplacementNamed(AppRoutes.painterPointsScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
      default:
        context.pushReplacementNamed(AppRoutes.painterHomeScreen.name,
            extra: begin,
            pathParameters: {'lang': context.locale.languageCode});
        return;
    }
  }
}
