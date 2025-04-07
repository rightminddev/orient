import 'package:flutter/material.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../utils/modal_sheet_helper.dart';
import '../../models/reward_and_penalty.model.dart';
import '../../services/rewards_and_penalties.service.dart';
import '../rewards_and_penalties_details_modal.dart';

class RewardAndPenaltyCardWidget extends StatelessWidget {
  final RewardAndPenaltyModel rewardAndPenalty;
  const RewardAndPenaltyCardWidget({super.key, required this.rewardAndPenalty});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async => await ModalSheetHelper.showModalSheet(
              context: context,
              modalContent: RewardAndPenaltyDetailsModalSheet(
                rewardAndpenalty: rewardAndPenalty,
              ),
              title: rewardAndPenalty.type?.value
                          ?.toLowerCase()
                          .contains('reward') ==
                      true
                  ? 'Reward Info'
                  : 'Penalty Info',
              height: AppSizes.s400),
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.s14, horizontal: AppSizes.s16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.s10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  offset: const Offset(0, 0),
                  blurRadius: 2.5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  RewardsAndPenaltiesService.getRewardAndPenaltyImage(
                      type: rewardAndPenalty.type?.value),
                  width: AppSizes.s24,
                ),
                gapW8,
                Expanded(
                  child: Text(
                    RewardsAndPenaltiesService.formatDate(
                            rewardAndPenalty.createdAt) ??
                        '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.s14,
                      color: Colors.black,
                    ),
                  ),
                ),
                gapW8,
                Container(
                  height: AppSizes.s28,
                  width: AppSizes.s28,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary),
                  child: const Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                    size: AppSizes.s18,
                  ),
                ),
              ],
            ),
          ),
        ),
        gapH20
      ],
    );
  }
}
