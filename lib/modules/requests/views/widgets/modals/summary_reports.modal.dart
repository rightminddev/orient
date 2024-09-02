import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../../../constants/app_strings.dart';
import '../../../models/summary_report.model.dart';

class SummaryReportsModal extends StatelessWidget {
  final List<SummaryReportModel> summaryReports;
  const SummaryReportsModal({super.key, required this.summaryReports});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        gapH16,
        Expanded(
          child: ListView.builder(
            itemCount: summaryReports.length,
            itemBuilder: (context, index) {
              final report = summaryReports[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.s8),
                child: Container(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.grey[200] : Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      '${report.month ?? ''} - ${report.year}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing:
                        Text('${report.duration} ${AppStrings.days.tr()}'),
                  ),
                ),
              );
            },
          ),
        ),
        gapH16
      ],
    );
  }
}
