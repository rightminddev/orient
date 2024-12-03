import 'package:flutter/material.dart';
import 'package:orient/models/teams/team_details_model.dart';
import 'package:orient/models/teams/team_model.dart';
import 'package:orient/models/teams/top_rated_teams_model.dart';
import '../../../../services/crud_operation.service.dart';
import '../services/teams.service.dart';

class TeamsViewModel extends ChangeNotifier {
  List<TeamModel> teamsList = List.empty(growable: true);
  TeamDetailsModel? teamDetails;
  TopRatedTeamsModel topRatedTeamsModel = TopRatedTeamsModel();
  final ScrollController controller = ScrollController();
  int pageNumber = 1;
  List teamMembers = [];
  List requestMembers = [];
  int count = 0;
  bool isLoading = true;
  final int expectedPageSize = 9;
  ScrollController get scrollController => controller;
  bool hasMoreData(int length) {
    if (length < expectedPageSize) {
      return false; // No more data available if we received less than expected
    } else {
      pageNumber += 1; // Increment for the next page
      return true; // More data available
    }
  }
  void updateLoadingStatus({required bool laodingValue}) {
    isLoading = laodingValue;
    notifyListeners();
  }

  Future<void> initializeTeamList(BuildContext context,String slug, {name}) async {
    updateLoadingStatus(laodingValue: true);
    await _getTeamsList(context,slug: slug, name: name);
    updateLoadingStatus(laodingValue: false);
  }

  Future<void> initializeTeamDetailsScreen(
      BuildContext context, int teamId) async {
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
        String slug = "",
        String name = ""
      }) async {
    try {
      final result = await CrudOperationService.readEntities(
        context: context,
        slug: slug,
        queryParams: {
          if(name == "") "page": pageNumber,
          "scope": scope,
          if(name != "") "name": name
        },
      );
      if (result.success && result.data != null) {
        final List<dynamic> newTeams = result.data?['data'] ?? [];
        if (pageNumber == 1) {
          teamsList.clear();
        }
        for (var v in newTeams) {
          teamsList.add(TeamModel.fromJson(v));
        }
        if (newTeams.length < expectedPageSize) {
          count = teamsList.length;
        } else {
        }
      }
      debugPrint(teamsList.length.toString());
      notifyListeners(); // Notify listeners after updating the list
    } catch (err, t) {
      debugPrint("Error while getting teams list: ${err.toString()} at: $t");
    }
  }


  Future<void> _getTeamDetails(BuildContext context, int teamId) async {
    notifyListeners();
    isLoading = true;
    try {
      final result =
          await TeamsService.getTeamDetails(context: context, teamId: teamId);

      if (result.success && result.data != null) {
        teamDetails = TeamDetailsModel.fromJson(result.data?['team']);
        teamDetails!.members!.forEach((e){
          if(e.pivot!.status == "pending"){
            print("IS PENDEND");
            requestMembers.add(e);
            print("LENGTH IS ---> ${requestMembers.length}");
          }else{
            teamMembers.clear();
            teamMembers.add(e);
          }
        });
        isLoading = false;
        notifyListeners();
      }
    } catch (err, t) {
      isLoading = false;
      notifyListeners();
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
