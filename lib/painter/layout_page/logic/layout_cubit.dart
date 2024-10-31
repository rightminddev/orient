import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/modules/painters/teams/views/teams_screen.dart';
import 'package:orient/painter/group_page/groups_page.dart';
import 'package:orient/painter/home_screen/views/painter_main_screen.dart';
import 'package:orient/painter/points/points_screen.dart';
import 'package:orient/painter/settings_page/settings_page.dart';

import 'layout_state.dart';


class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<Widget> navList = [
    const HomeScreen(),
    const GroupsPage(),
    const TeamsScreen(),
    const PointsScreen(),
    const SettingsPage(),
  ];
  List<IconData> navIcon = [
    Icons.home,
    Icons.person,
    Icons.grid_view_outlined,
    Icons.shopping_bag,
    Icons.menu
  ];

  int navIndex = 0;

  void changeIndex(BuildContext context,int index) {
    if (index == 3) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return PointsScreen();
      }));
    }
    else{
      navIndex = index;
    }

    emit(ChangeIndexState());
  }
}
