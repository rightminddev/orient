import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/points/widgets/condition_section.dart';
import 'package:orient/painter/points/widgets/copoun_section.dart';
import 'package:orient/painter/points/widgets/history_item.dart';
import 'package:orient/painter/points/widgets/history_section.dart';
import 'package:orient/utils/components/general_components/general_components.dart';



import '../logic/points_cubit/points_cubit.dart';
import '../logic/points_cubit/points_state.dart';

class SliverListPoints extends StatelessWidget {
  const SliverListPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointsCubit,PointsState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) {

              return Container(
                // padding: EdgeInsets.symmetric(horizontal: 23, vertical: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 22,),
                      defaultTapBarItem(items: ["Coupon","Conditions","History"]),
                      const SizedBox(height: 29,),
                      PointsCubit.get(context).selectedIndex == 0 ?
                      CopounSection() :
                      PointsCubit.get(context).selectedIndex == 1?
                      const ConditionSection()
                          :
                      HistoryItem(),
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
