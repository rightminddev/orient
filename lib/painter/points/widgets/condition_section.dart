import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import '../logic/condition_cubit/condition_provider.dart';

class ConditionSection extends StatelessWidget {
  const ConditionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final conditionProvider = Provider.of<ConditionProvider>(context);
    if (conditionProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (conditionProvider.errorMessage != null) {
      return Text(conditionProvider.errorMessage!);
    } else if (conditionProvider.termsAndConditionsModel != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HtmlWidget(
              '''
                  ${conditionProvider.termsAndConditionsModel!.page!.content}
  ''',
              renderMode: RenderMode.column,
              textStyle: const TextStyle(fontSize: 14, color: Color(0xff464646), fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );
    }else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }



  }
}
