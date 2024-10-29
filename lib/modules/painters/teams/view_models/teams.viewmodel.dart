import 'package:flutter/material.dart';
import 'package:orient/models/teams/team_details_model.dart';
import 'package:orient/models/teams/team_model.dart';
import 'package:orient/models/teams/top_rated_teams_model.dart';
import '../../../../services/crud_operation.service.dart';
import '../services/teams.service.dart';

class TeamsViewModel extends ChangeNotifier {
  List<TeamModel> teamsList = List.empty(growable: true);
  TeamDetailsModel teamDetails = TeamDetailsModel();
  TopRatedTeamsModel topRatedTeamsModel = TopRatedTeamsModel();

  bool isLoading = true;
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeTeamList(BuildContext context,String slug) async {
    updateLoadingStatus(laodingValue: true);
    await _getTeamsList(context,slug: slug);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> initializeTeamDetailsScreen(
      BuildContext context, int teamId,String slug) async {
    updateLoadingStatus(laodingValue: true);
    await _getTeamDetails(context, teamId);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> initializeTopRated(BuildContext context) async {
    updateLoadingStatus(laodingValue: true);
    await _getTopRated(context);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> _getTeamsList(
    BuildContext context, {
    String scope = 'filter',
    String slug =""
  }) async {
    try {
      final result = await CrudOperationService.readEntities(
        context: context,
        slug: slug,
        queryParams: {
          "scope": scope,
          'page': 1,
          'with': 'cate',
          'trash': 1,
        },
      );
      teamsList = teamsList.isNotEmpty ? List.empty(growable: true) : teamsList;

      if (result.success && result.data != null) {
        (result.data?['data'] ?? []).forEach((v) {
          teamsList.add(TeamModel.fromJson(v));
        });
      }

      debugPrint(teamsList.length.toString());
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> _getTeamDetails(BuildContext context, int teamId) async {
    try {
      final result =
          await TeamsService.getTeamDetails(context: context, teamId: teamId);

      if (result.success && result.data != null) {
        teamDetails = TeamDetailsModel.fromJson(result.data?['team']);
      }
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }

  Future<void> _getTopRated(BuildContext context) async {
    try {
      final result = await TeamsService.getTopRated(context: context);

      if (result.success && result.data != null) {
        topRatedTeamsModel = TopRatedTeamsModel.fromJson(result.data?['data']);
      }
    } catch (err, t) {
      debugPrint(
          "error while getting Employee Details  ${err.toString()} at :- $t");
    }
  }
}
