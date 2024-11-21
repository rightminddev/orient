import 'package:flutter/material.dart';
import 'package:orient/modules/settings_page/setting_page_two.dart';
import 'package:orient/painter/group_page/groups_page.dart';
import 'package:orient/painter/home_screen/views/painter_main_screen.dart';
import 'package:orient/painter/layout_page/logic/layout_provider.dart';
import 'package:orient/painter/points/points_screen.dart';
import 'package:orient/painter/teams/views/teams_screen.dart';
import 'package:orient/routing/app_router.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:provider/provider.dart';

class LayoutPageScreen extends StatefulWidget {
  final PainterNavbarPages painterNavbarPages;
  final Widget child;
  LayoutPageScreen(
      {super.key, required this.painterNavbarPages, required this.child});
  @override
  State<LayoutPageScreen> createState() => _LayoutPageScreenState();
}

class _LayoutPageScreenState extends State<LayoutPageScreen> {
  int selectIndex = 0;
  final List<Widget> pages = [
    HomeScreen(),
    GroupsPage(viewArrow: false,),
    const TeamsScreen(),
    PointsScreen(arrow: false,),
    SettingsPageTwo(),
  ];
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PainterMainScreenViewModel>(context);
    viewModel.currentPage = widget.painterNavbarPages;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: pages[selectIndex],
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          height: 115,
          clipBehavior: Clip.none,
          color: const Color(0xffFFFFFF),
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: defaultBottomNavigationBar(
              items: viewModel.navs,
              selectIndex: selectIndex,
              tapBarItemsWidth: MediaQuery.sizeOf(context).width * 0.9,
              onTapItem: (index) {
                print(index);
                print(widget.child);
                setState(() {
                  selectIndex = index;
                });
                viewModel.onNavItemTapped(index, context);
                print("Tapped index: $index, Current page: ${viewModel.currentPage}");
                if (index == 0) {
                  viewModel.onItemTapped(
                      context: context,
                      page: PainterNavbarPages.painterHomeScreen);
                  print(index);
                }
                if (index == 1) {
                  viewModel.onItemTapped(
                      context: context,
                      page: PainterNavbarPages.painterMyGroupsScreen);
                }
                if (index == 2) {
                  viewModel.onItemTapped(
                      context: context,
                      page: PainterNavbarPages.painterTeamsScreen);
                  print(index);
                }
                if (index == 3) {
                  viewModel.onItemTapped(
                      context: context,
                      page: PainterNavbarPages.painterPointsScreen);
                  print(index);
                }
                if (index == 4) {
                  viewModel.onItemTapped(
                      context: context,
                      page: PainterNavbarPages.painterProfileScreen);
                  print(index);
                }
              }),
        ),
      ),
    );
  }
}
