import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/points/data/repositories/condition_repository/condition_repository_implementation.dart';
import 'package:orient/painter/points/data/repositories/prize_repository/prize_repository_implementation.dart';
import 'package:orient/painter/points/logic/condition_cubit/condition_cubit.dart';
import 'package:orient/painter/points/logic/prize_cubit/prize_cubit.dart';
import 'package:orient/painter/points/widgets/sliver_app_bar_points.dart';
import 'package:orient/painter/points/widgets/sliver_list_points.dart';

import 'data/repositories/history_repository/get_history_repository_implementation.dart';
import 'data/repositories/redeem_prize_repository/redeem_prize_repository_implementation.dart';
import 'logic/history_cubit/history_cubit.dart';

import 'logic/points_cubit/points_cubit.dart';
import 'logic/redeem_prize_cubit/redeem_prize_cubit.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PointsCubit()),
        BlocProvider(create: (context) => HistoryCubit(GetHistoryRepositoryImplementation(ApiServicesImplementation()))..getHistory()),
        BlocProvider(create: (context) => PrizeCubit(GetPrizeRepositoryImplementation(ApiServicesImplementation()))),
        BlocProvider(create: (context) => ConditionCubit(GetConditionRepositoryImplementation(ApiServicesImplementation()))..getCondition()),
      ],
      child: const Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBarPoints(),
          SliverListPoints(),
        ],
      ),
    ),

    );
  }
}
