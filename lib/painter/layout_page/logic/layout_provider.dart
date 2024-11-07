import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orient/constants/app_images.dart';
import 'package:orient/painter/group_page/groups_page.dart';
import 'package:orient/painter/points/points_screen.dart';
import 'package:orient/painter/settings_page/settings_page.dart';
import '../../../routing/app_router.dart';
import '../../home_screen/views/painter_main_screen.dart';
import '../../teams/views/teams_screen.dart';

// class LayoutProvider extends ChangeNotifier {
//   List<Widget> navList = [
//     const HomeScreen(),
//     const GroupsPage(),
//     const TeamsScreen(),
//     const PointsScreen(),
//     const SettingsPage(),
//   ];
//
//   List<String> navIcon = [
//     "assets/images/ecommerce/svg/nav1.svg",
//     "assets/images/ecommerce/svg/nav2.svg",
//     "assets/images/ecommerce/svg/nav3.svg",
//     "assets/images/ecommerce/svg/nav4.svg",
//     "assets/images/ecommerce/svg/nav5.svg",
//   ];
//
//   int navIndex = 0;
//
//   void changeIndex(BuildContext context, int index) {
//     if (index == 3) {
//       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//         return PointsScreen();
//       }));
//     } else {
//       navIndex = index;
//       notifyListeners(); // Notify the UI of changes
//     }
//   }
// }

////////////////////////
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
      case SettingsPage _:
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
        return const GroupsPage();
      case PainterNavbarPages.painterTeamsScreen:
        return TeamsScreen();
      case PainterNavbarPages.painterPointsScreen:
        return  PointsScreen();
      case PainterNavbarPages.painterProfileScreen:
        return SettingsPage();
      default:
        return  HomeScreen();
    }
  }

  Future<void> onItemTapped(
      {required BuildContext context, required PainterNavbarPages page}) async {
    if (page == currentPage) return;
    int oldIndex = pageIndex;
    int newIndex = PainterNavbarPages.values.indexOf(page);
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
