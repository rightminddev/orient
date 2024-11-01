import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/core/api/api_services_implementation.dart';
import 'package:orient/painter/points/data/repositories/condition_repository/condition_repository_implementation.dart';
import 'package:orient/painter/points/data/repositories/history_repository/get_history_repository_implementation.dart';
import 'package:orient/painter/points/logic/condition_cubit/condition_provider.dart';
import 'package:orient/painter/points/logic/history_cubit/history_provider.dart';
import 'package:orient/painter/points/logic/points_cubit/points_provider.dart';
import 'package:orient/painter/points/widgets/condition_section.dart';
import 'package:orient/painter/points/widgets/copoun_section.dart';
import 'package:orient/painter/points/widgets/history_item.dart';
import 'package:orient/utils/components/general_components/general_components.dart';
import 'package:provider/provider.dart';

class SliverListPoints extends StatelessWidget {
  const SliverListPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PointsProvider>(
      builder: (context, provider, child) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) {

              return Container(
                // padding: EdgeInsets.symmetric(horizontal: 23, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 22,),
                      defaultTap2BarItem(items: ["Coupon","Conditions","History"]),
                      SizedBox(height: 29,),
                      provider.selectedIndex == 0 ?
                      CopounSection() :
                      provider.selectedIndex == 1?
                      ChangeNotifierProvider(
                          create: (_) => ConditionProvider(GetConditionRepositoryImplementation(ApiServicesImplementation()))..getCondition(),
                          child: ConditionSection())
                          :
                      ChangeNotifierProvider(
                          create: (context) => HistoryProvider(GetHistoryRepositoryImplementation(ApiServicesImplementation()))..getHistory(),
                          child: HistoryItem()),
                    ],
                  ),
                ),
              );
            },
            childCount: 1,
          ),
        );
      },
    );
  }
}
