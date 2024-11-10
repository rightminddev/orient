import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/points/data/repositories/history_repository/get_history_repository_implementation.dart';
import 'package:orient/painter/points/data/repositories/prize_repository/prize_repository_implementation.dart';
import 'package:orient/painter/points/logic/points_cubit/points_provider.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_provider.dart';
import 'package:orient/painter/points/widgets/sliver_app_bar_points.dart';
import 'package:orient/painter/points/widgets/sliver_list_points.dart';
import 'package:orient/utils/components/general_components/gradient_bg_image.dart';

import 'package:provider/provider.dart';

class PointsScreen extends StatefulWidget {
  bool arrow;
  PointsScreen({super.key, required this.arrow});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PointsProvider()),
        // BlocProvider(create: (context) => HistoryCubit(GetHistoryRepositoryImplementation(ApiServicesImplementation()))..getHistory()),

        //BlocProvider(create: (context) => ConditionCubit(GetConditionRepositoryImplementation(ApiServicesImplementation()))..getCondition()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => PrizeProvider(
            GetPrizeRepositoryImplementation(ApiServicesImplementation(),context)),
        child: Scaffold(
          backgroundColor: Color(0xffFFFFFF),
          body: GradientBgImage(
            padding: EdgeInsets.zero,
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: [
                SliverAppBarPoints(arrow: widget.arrow,),
                SliverListPoints(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
