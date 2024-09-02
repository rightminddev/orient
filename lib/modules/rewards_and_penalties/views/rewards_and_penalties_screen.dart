import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../common_modules_widgets/custom_floating_action_button.widget.dart';
import '../../../common_modules_widgets/payrolls_and_penalties_and_rewards_loading_screens.widget.dart';
import '../../../common_modules_widgets/template_page.widget.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_sizes.dart';
import '../../../general_services/layout.service.dart';
import '../../../routing/app_router.dart';
import '../../../utils/general_screen_message_widget.dart';
import '../../../utils/placeholder_no_existing_screen/no_existing_placeholder_screen.dart';
import '../view_models/rewards_and_penalties.viewmodel.dart';
import 'widgets/reward_and_penalty_card.widget.dart';

class RewardsAndPenaltiesScreen extends StatefulWidget {
  final String? empId;
  final String? empName;
  const RewardsAndPenaltiesScreen({super.key, this.empId, this.empName});

  @override
  State<RewardsAndPenaltiesScreen> createState() =>
      _RewardsAndPenaltiesScreenState();
}

class _RewardsAndPenaltiesScreenState extends State<RewardsAndPenaltiesScreen> {
  late final RewardsAndPenaltiesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = RewardsAndPenaltiesViewModel();
    viewModel.initializeRewardsAndPenaltiesListScreen(
        context: context, empId: widget.empId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RewardsAndPenaltiesViewModel>(
      create: (_) => viewModel,
      child: TemplatePage(
          floatingActionButton: CustomFloatingActionButton(
            iconPath: AppImages.addFloatingActionButtonIcon,
            onPressed: () async => await context.pushNamed(
                AppRoutes.addRewardsAndPenalties.name,
                pathParameters: {'lang': context.locale.languageCode}),
            tagSuffix: 'add',
            height: AppSizes.s16,
            width: AppSizes.s16,
          ),
          pageContext: context,
          bottomAppbarWidget: widget.empId != null &&
                  widget.empId?.isNotEmpty == true &&
                  widget.empName != null &&
                  widget.empName?.isNotEmpty == true &&
                  viewModel.userSettings?.userId.toString() != widget.empId
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(AppSizes.s40),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s12, vertical: AppSizes.s6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          widget.empName!,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: AppSizes.s20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                )
              : null,
          title: 'REWARD AND PENALTIES',
          onRefresh: () async =>
              await viewModel.initializeRewardsAndPenaltiesListScreen(
                  context: context, empId: widget.empId),
          body: Padding(
            padding: const EdgeInsets.all(AppSizes.s12),
            child: SingleChildScrollView(
              child: Consumer<RewardsAndPenaltiesViewModel>(
                  builder: (context, viewModel, child) => viewModel.isLoading
                      ? const PayrollsAndPenaltiesRewardsLoadingScreensWidget()
                      : viewModel.rewardsAndPenalties?.isEmpty == true ||
                              viewModel.rewardsAndPenalties == null
                          ? NoExistingPlaceholderScreen(
                              height: LayoutService.getHeight(context) * 0.6,
                              title: 'No Existing Penalties and Rewards')
                          : Column(children: [
                              /// general screen message widget for other requests types
                              const GeneralScreenMessageWidget(
                                  screenId: '/penalties-and-rewards'),
                              ...viewModel.rewardsAndPenalties!.map(
                                  (rewardAndPenalty) =>
                                      RewardAndPenaltyCardWidget(
                                        rewardAndPenalty: rewardAndPenalty,
                                      ))
                            ])),
            ),
          )),
    );
  }
}
