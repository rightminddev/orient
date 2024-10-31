import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orient/painter/points/logic/condition_cubit/condition_state.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../logic/condition_cubit/condition_cubit.dart';

class ConditionSection extends StatelessWidget {
  const ConditionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConditionCubit, ConditionState>(
      builder: (context, state) {
        if (state is GetConditionSuccessState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HtmlWidget(
                  '''
                  ${ConditionCubit.get(context).termsAndConditionsModel!.page!.content}
  ''',
                  renderMode: RenderMode.column,
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        } else if (state is GetConditionFailureState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
