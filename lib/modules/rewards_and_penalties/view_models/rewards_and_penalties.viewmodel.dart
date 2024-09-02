import 'package:flutter/material.dart';
import '../../../general_services/settings.service.dart';
import '../../../models/settings/user_settings.model.dart';
import '../models/reward_and_penalty.model.dart';
import '../services/rewards_and_penalties.service.dart';

class RewardsAndPenaltiesViewModel extends ChangeNotifier {
  List<RewardAndPenaltyModel>? rewardsAndPenalties;
  UserSettingsModel? userSettings;
  bool isLoading = true;

  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeRewardsAndPenaltiesListScreen(
      {required BuildContext context, required String? empId}) async {
    updateLoadingStatus(laodingValue: true);
    userSettings = AppSettingsService.getSettings(
        settingsType: SettingsType.userSettings,
        context: context) as UserSettingsModel;
    await _getRewardsAndPenalties(context: context);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getRewardsAndPenalties(
      {required BuildContext context, String? empId}) async {
    try {
      final result =
          await RewardsAndPenaltiesService.getRewardsAndPenaltiesList(
              context: context, empId: empId, withValues: ['employee_id']);
      if (result.success && result.data != null) {
        var rewardsAndPenaltiesListData =
            result.data?['data'] as List<dynamic>?;
        rewardsAndPenalties = rewardsAndPenaltiesListData
            ?.map((item) =>
                RewardAndPenaltyModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (err, t) {
      debugPrint(
          "error while getting user rewardsAndPenaltiesListData  list ${err.toString()} at :- $t");
    }
  }
}
