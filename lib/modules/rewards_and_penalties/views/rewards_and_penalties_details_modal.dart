import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants/app_sizes.dart';
import '../models/reward_and_penalty.model.dart';

class RewardAndPenaltyDetailsModalSheet extends StatelessWidget {
  final RewardAndPenaltyModel rewardAndpenalty;
  const RewardAndPenaltyDetailsModalSheet(
      {super.key, required this.rewardAndpenalty});

  @override
  Widget build(BuildContext context) {
    String? formatDateString(String? dateString) {
      if (dateString == null) return null;
      // Parse the string into a DateTime object
      DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);

      // Format the DateTime object into the desired format
      String formattedDate = DateFormat('EEEE, dd MMM yyyy').format(dateTime);

      return formattedDate;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        gapH16,
        //TODO: DISPLAY THE EMPLOYEE AND THE USER THAT MAKE TO HIM THE REWARD OR PENALTY
        // if (formatDateString(rewardAndpenalty.createdAt) != null) ...[
        //   gapH12,
        //   Container(
        //     padding: const EdgeInsets.all(AppSizes.s12),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(AppSizes.s10),
        //       color: Theme.of(context).colorScheme.secondary,
        //     ),
        //     child: Center(
        //       child: Text(
        //         formatDateString(rewardAndpenalty.createdAt) ?? '',
        //         style: const TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.w500,
        //             fontSize: AppSizes.s14),
        //       ),
        //     ),
        //   ),
        // ],
        // gapH12,
        if (rewardAndpenalty.type?.value?.isNotEmpty ?? false)
          RewardAndPenaltyRowTile(
              title: 'Rewards and Penalties Type: ',
              subtitle: rewardAndpenalty.type!.value!),

        if (rewardAndpenalty.amount != null)
          RewardAndPenaltyRowTile(
              title: 'Amount: ',
              subtitle: rewardAndpenalty.amount?.toString() ?? ''),

        if (rewardAndpenalty.createdAt?.isNotEmpty ?? false)
          RewardAndPenaltyRowTile(
              title: 'Date: ',
              subtitle: formatDateString(rewardAndpenalty.createdAt) ?? ''),

        if (rewardAndpenalty.reason?.isNotEmpty ?? false)
          RewardAndPenaltyRowTile(
              title: 'Reason: ', subtitle: rewardAndpenalty.reason!)
      ],
    );
  }
}

class RewardAndPenaltyRowTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool? isNewLine;
  const RewardAndPenaltyRowTile(
      {super.key,
      required this.title,
      required this.subtitle,
      this.isNewLine = false});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w600,
        fontSize: AppSizes.s16);
    Widget titleWidget = AutoSizeText(title, style: textStyle);
    Widget subtitleWidget = Expanded(
      child: AutoSizeText(subtitle,
          style: textStyle.copyWith(color: Colors.black)),
    );
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          isNewLine == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [titleWidget, subtitleWidget],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [titleWidget, subtitleWidget],
                ),
          gapH16,
        ],
      ),
    );
  }
}
